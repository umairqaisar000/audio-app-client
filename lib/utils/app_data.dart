import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livekit_client/livekit_client.dart';

class AppProviderContainer {
  static final ProviderContainer instance = ProviderContainer();
  static num? currentRoomId;
  static Room? currentRoom;
  static EventsListener<RoomEvent>? listener;
  // static User? userData;
}
