import 'package:livekit_client/livekit_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'livekit_rooms_provider.g.dart';

@Riverpod(keepAlive: true)
class LivekitRoomsNotifier extends _$LivekitRoomsNotifier {
  @override
  Map<String, Room> build() {
    return {};
  }

  void addOrUpdateRoom(Room room) {
    if (room.name != null) {
      // Explicitly creating a new map and copying existing entries
      final updatedState = Map<String, Room>.from(state)..[room.name!] = room;
      state = updatedState;
    }
  }

  void removeRoom(String roomId) {
    if (state.containsKey(roomId)) {
      // Create a new map with all entries except the one to be removed
      final updatedState = Map<String, Room>.from(state)..remove(roomId);
      state = updatedState;
    }
  }
}

@riverpod
Room? livekitRoomNotifier(LivekitRoomNotifierRef ref, String roomId) {
  final rooms = ref.watch(livekitRoomsNotifierProvider);
  return rooms[roomId];
}
