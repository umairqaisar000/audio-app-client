// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/responses/join_room_response.dart';
import 'package:audio_app/responses/room_response.dart';
import 'package:audio_app/utils/app_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';

class RoomService {
  static RoomService shared = RoomService();
  Future<RoomResponse?> getRoom() async {
    debugPrint('get rooms called');
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/room/get-rooms');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        return RoomResponse.fromJson(jsonResponse);
      } else {
        debugPrint('Error with fetching profiles');
        debugPrint('HTTP Error Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }

  Future<JoinRoomResponse?> joinRoom(num roomId, num userId) async {
    debugPrint('join room called');
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/join-room');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = {
      "roomId": roomId.toString(),
      "userId": userId.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        AppProviderContainer.currentRoomId = roomId;
        return JoinRoomResponse.fromJson(jsonResponse);
      } else {
        debugPrint('Error with fetching profiles');
        debugPrint('HTTP Error Code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return null;
    }
  }

  Future<void> addToAllRooms(num userId) async {
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/add-to-all-rooms');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = {
      "userId": userId.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        final List<dynamic> tokens = (jsonResponse['data']);
        const url = Endpoints.liveKitSfuUrl;

        for (var token in tokens) {
          final room = Room();
          // Create a Listener before connecting
          final listener = room.createListener();
          await room.connect(url, token,
              connectOptions: const ConnectOptions(autoSubscribe: false));
          if (room.name != null) {
            AppProviderContainer.allRooms[room.name!] = room;
            AppProviderContainer.allRoomsListeners[room.name!] = listener;
          }
        }
      } else {
        debugPrint('Error with fetching profiles');
        debugPrint('HTTP Error Code: ${response.statusCode}');
        return;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return;
    }
  }

  Future<void> leaveRoom(num roomId, num userId) async {
    debugPrint('leave room called');
    String baseUrl = Endpoints.baseUrl;
    final url = Uri.parse('$baseUrl/leave-room');

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final payload = {
      "roomId": roomId.toString(),
      "userId": userId.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(payload),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        debugPrint(response.body.toString());
        final jsonResponse = json.decode(response.body);
        return;
      } else {
        debugPrint('Error with fetching profiles');
        debugPrint('HTTP Error Code: ${response.statusCode}');
        return;
      }
    } catch (error) {
      debugPrint('Error: $error');
      return;
    }
  }
}

/// for more information, see [event types](https://docs.livekit.io/client/events/#events)
void _setUpListeners(EventsListener<RoomEvent> listener) => listener
  ..on<RoomDisconnectedEvent>((event) async {
    if (event.reason != null) {
      print('Room disconnected: reason => ${event.reason}');
    }
  })
  ..on<ParticipantEvent>((event) {
    // sort participants on many track events as noted in documentation linked above
    print("participant Event: ${event.toString()}");
  })
  ..on<RoomAttemptReconnectEvent>((event) {
    print('Attempting to reconnect ${event.attempt}/${event.maxAttemptsRetry}, '
        '(${event.nextRetryDelaysInMs}ms delay until next attempt)');
  })
  ..on<LocalTrackPublishedEvent>((_) => print("======"))
  ..on<LocalTrackUnpublishedEvent>((_) => print("======"))
  ..on<TrackSubscribedEvent>((_) => print("======"))
  ..on<TrackUnsubscribedEvent>((_) => print("======"))
  ..on<ParticipantNameUpdatedEvent>((event) {
    print(
        'Participant name updated: ${event.participant.identity}, name => ${event.name}');
  })
  ..on<ParticipantMetadataUpdatedEvent>((event) {
    print(
        'Participant metadata updated: ${event.participant.identity}, metadata => ${event.metadata}');
  })
  ..on<RoomMetadataChangedEvent>((event) {
    print('Room metadata changed: ${event.metadata}');
  })
  ..on<DataReceivedEvent>((event) {
    String decoded = 'Failed to decode';
    try {
      decoded = utf8.decode(event.data);
    } catch (_) {
      print('Failed to decode: $_');
    }
  })
  ..on<AudioPlaybackStatusChanged>((event) async {});
