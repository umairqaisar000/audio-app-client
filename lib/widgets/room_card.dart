import 'dart:async';

import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/views/call_room_view.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';

class RoomCard extends StatefulWidget {
  const RoomCard({super.key, this.roomName, this.capacity});
  final String? roomName;
  final int? capacity;

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  List<MediaDevice> _audioInputs = [];
  LocalAudioTrack? _audioTrack;
  bool _enableAudio = true;
  StreamSubscription? _subscription;
  MediaDevice? _selectedAudioDevice;

  @override
  void initState() {
    super.initState();
    _subscription =
        Hardware.instance.onDeviceChange.stream.listen(_loadDevices);
    Hardware.instance.enumerateDevices().then(_loadDevices);
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
    const url = Endpoints.liveKitSfuUrl;
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3Mjg2NDU1NjcsImlzcyI6ImRldmtleSIsIm5hbWUiOiJ1bWFpciIsIm5iZiI6MTcyODU1OTE2Nywic3ViIjoidW1haXIiLCJ2aWRlbyI6eyJyb29tIjoicWNvcmUiLCJyb29tSm9pbiI6dHJ1ZX19.fE6Oeip6jWM6018pnT5mU9gf-uNFMjE1PnGdWnGt4ws';

    final room = Room();

    _setEnableAudio(true);
    print(_audioTrack);
    // Create a Listener before connecting
    final listener = room.createListener();
    await room.connect(url, token,
        fastConnectOptions: FastConnectOptions(
          microphone: TrackOption(track: _audioTrack),
        ));

    await Navigator.push<void>(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => RoomPage(room, listener)),
    );
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
                widget.roomName ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: (widget.capacity ?? 0) < 3
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ...List.generate(widget.capacity ?? 5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Theme.of(context).focusColor,
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
