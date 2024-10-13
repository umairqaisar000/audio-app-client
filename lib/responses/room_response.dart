import 'package:audio_app/models/room.dart';

class RoomResponse {
  RoomResponse({required this.rooms});

  factory RoomResponse.fromJson(Map<String, dynamic> json) {
    var list = json['rooms'] as List;
    List<Room> roomsList = list.map((i) => Room.fromJson(i)).toList();
    return RoomResponse(rooms: roomsList);
  }

  final List<Room> rooms;
}
