import 'package:audio_app/models/room.dart';
import 'package:audio_app/services/get_rooms_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rooms_notifier.g.dart'; // This is the generated file

@Riverpod(keepAlive: true)
class RoomsNotifier extends _$RoomsNotifier {
  @override
  List<Room> build() {
    return []; // Initial state
  }

  Future<void> fetchRooms() async {
    final roomService = RoomService();
    final response = await roomService.getRoom();
    if (response != null) {
      state = response.rooms;
    }
  }

  void updateRooms(List<dynamic> roomsData) {
    state = roomsData.map((data) => Room.fromJson(data)).toList();
  }

  void userJoinedRoom(num roomId, num userId) {
    state = [
      for (final room in state)
        if (room.id == roomId)
          room.copyWith(users: [...room.users, userId])
        else
          room
    ];
  }

  void userLeftRoom(num roomId, num userId) {
    state = [
      for (final room in state)
        if (room.id == roomId)
          room.copyWith(users: room.users.where((id) => id != userId).toList())
        else
          room
    ];
  }

  void userDisconnected(num userId) {
    state = [
      for (final room in state)
        room.copyWith(users: room.users.where((id) => id != userId).toList())
    ];
  }

  Room? getRoomById(num id) {
    return state.firstWhere((room) => room.id == id, orElse: () => Room());
  }
}
