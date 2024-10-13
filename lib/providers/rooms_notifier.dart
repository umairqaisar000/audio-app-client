import 'package:audio_app/models/room.dart';
import 'package:audio_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rooms_notifier.g.dart'; // This is the generated file

@Riverpod(keepAlive: true)
class RoomsNotifier extends _$RoomsNotifier {
  @override
  List<AudioRoom> build() {
    return []; // Initial state
  }

  void updateRooms(List<dynamic> roomsData) {
    state = roomsData.map((data) => AudioRoom.fromJson(data)).toList();
  }

  AudioRoom? getRoomById(num id) {
    try {
      return state.firstWhere((room) => room.id == id);
    } catch (e) {
      return null;
    }
  }
}
