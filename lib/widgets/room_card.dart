import 'dart:async';
import 'dart:math';

import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/models/room.dart';
import 'package:audio_app/models/user.dart';
import 'package:audio_app/providers/user_notifier.dart';
import 'package:audio_app/services/room_service.dart';
import 'package:audio_app/utils/app_data.dart';
import 'package:audio_app/utils/utils.dart';
import 'package:audio_app/views/call_room_view.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class RoomCard extends StatefulWidget {
  const RoomCard({super.key, required this.room});
  final AudioRoom room;

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  List<MediaDevice> _audioInputs = [];
  LocalAudioTrack? _audioTrack;
  bool _enableAudio = true;
  StreamSubscription? _subscription;
  MediaDevice? _selectedAudioDevice;
  List<String> activeSpeakers = [];

  @override
  void initState() {
    super.initState();
    _subscription =
        Hardware.instance.onDeviceChange.stream.listen(_loadDevices);
    Hardware.instance.enumerateDevices().then(_loadDevices);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var listener =
          AppProviderContainer.allRoomsListeners[widget.room.id.toString()];

      listener?.on<TrackPublishedEvent>((e) {
        if (e.publication.kind == TrackType.AUDIO &&
            e.participant.identity !=
                AppProviderContainer.instance
                    .read(userNotifierProvider)
                    ?.name) {
          if (!e.publication.subscribed) {
            e.publication.subscribe();
          }
        }
      });
      listener?.on<TrackSubscribedEvent>((e) {
        muteOrUnmuteAllTracks(roomId: widget.room.name, enabled: false);
      });
      Room? room = AppProviderContainer.allRooms[widget.room.id.toString()];
      if (room != null) {
        // Also subscribe to tracks published before participant joined
        for (RemoteParticipant participant in room.remoteParticipants.values) {
          for (RemoteTrackPublication publication
              in participant.audioTrackPublications) {
            if (publication.kind == TrackType.AUDIO &&
                participant.identity !=
                    AppProviderContainer.instance
                        .read(userNotifierProvider)
                        ?.name) {
              if (!publication.subscribed) {
                publication.subscribe();
              }
            }
          }
        }
      }

      listener?.on<ActiveSpeakersChangedEvent>((event) {
        if (mounted) {
          setState(() {
            activeSpeakers = [];
            for (var speaker in event.speakers) {
              activeSpeakers.add(speaker.identity);
            }
          });
        }
      });
    });
  }

  Future<void> muteOrUnmuteAllTracks({
    required String roomId,
    bool enabled = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    Room? room = AppProviderContainer.allRooms[widget.room.id.toString()];
    if (room != null) {
      // Also subscribe to tracks published before participant joined
      for (RemoteParticipant participant in room.remoteParticipants.values) {
        for (RemoteTrackPublication publication
            in participant.audioTrackPublications) {
          if (publication.kind == TrackType.AUDIO) {
            if (publication.subscribed) {
              final track = publication.track;
              if (track != null) {
                publication.track?.mediaStreamTrack.enabled = enabled;
              }
            }
          }
        }
      }
    }
  }

  @override
  void deactivate() {
    _subscription?.cancel();
    super.deactivate();
  }

  void _loadDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();

    if (_audioInputs.isNotEmpty) {
      if (_selectedAudioDevice == null) {
        _selectedAudioDevice = _audioInputs.first;
        Future.delayed(const Duration(milliseconds: 100), () async {
          await _changeLocalAudioTrack();
          setState(() {});
        });
      }
    }
    setState(() {});
  }

  Future<void> _setEnableAudio(value) async {
    _enableAudio = value;
    if (!_enableAudio) {
      await _audioTrack?.stop();
      _audioTrack = null;
    } else {
      await _changeLocalAudioTrack();
    }
    setState(() {});
  }

  Future<void> _changeLocalAudioTrack() async {
    if (_audioTrack != null) {
      await _audioTrack!.stop();
      _audioTrack = null;
    }

    if (_selectedAudioDevice != null) {
      _audioTrack = await LocalAudioTrack.create(AudioCaptureOptions(
        deviceId: _selectedAudioDevice!.deviceId,
      ));
      await _audioTrack!.start();
    }
  }

  Future<void> _connect(BuildContext context) async {
    try {
      if (widget.room.id.toString() == AppProviderContainer.currentRoom?.name) {
        await Navigator.push<void>(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (_) => RoomPage(AppProviderContainer.currentRoom!,
                  AppProviderContainer.listener!)),
        );
        return;
      } else if (AppProviderContainer.currentRoom != null) {
        await AppProviderContainer.currentRoom!.disconnect();
        var user = AppProviderContainer.instance.read(userNotifierProvider);

        if (user != null && AppProviderContainer.currentRoomId != null) {
          debugPrint('leaving room');
          await RoomService()
              .leaveRoom(AppProviderContainer.currentRoomId!, user.id);
        }
      }
      const url = Endpoints.liveKitSfuUrl;

      final roomService = RoomService();
      var user = AppProviderContainer.instance.read(userNotifierProvider);
      if (user != null) {
        final response = await roomService.joinRoom(widget.room.id, user.id);
        if (response != null) {
          final token = response.data;
          final room = Room();
          _setEnableAudio(true);
          // Create a Listener before connecting
          final listener = room.createListener();
          await _audioTrack?.enable();
          await room.connect(url, token,
              fastConnectOptions: FastConnectOptions(
                microphone: TrackOption(track: _audioTrack, enabled: true),
              ));
          AppProviderContainer.currentRoom = room;
          AppProviderContainer.listener = listener;
          await Navigator.push<void>(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (_) => RoomPage(room, listener)),
          );
        }
      }
    } catch (error) {
      debugPrint("error:");
      debugPrint("error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _connect(context);
      },
      child: Container(
          width: 100,
          height: 126,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).focusColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Text(
                  widget.room.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: (widget.room.capacity ?? 0) < 3
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ...List.generate(max(widget.room.users.length, 5), (index) {
                      String initials = "";
                      User? user;
                      if (widget.room.users.length > index) {
                        // Extract the user from the room's users list based on index
                        user = widget.room.users.values.toList()[index];
                        // Extract initials from the user's name
                        initials = getInitials(user.name);
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white
                                  .withOpacity(0.5), // White with low opacity
                              width: activeSpeakers.contains(user?.name ?? '')
                                  ? 6
                                  : 2, // Animate border width
                            ),
                            color: Theme.of(context).focusColor,
                          ),
                          child: CircleAvatar(
                            radius: 32, // Inner CircleAvatar stays consistent
                            backgroundColor: Colors.transparent,
                            child: Text(
                              initials,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
