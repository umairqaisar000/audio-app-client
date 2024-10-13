import 'package:audio_app/models/room.dart';

class RoomResponse {
  RoomResponse({required this.rooms});

  factory RoomResponse.fromJson(Map<String, dynamic> json) {
    var list = json['rooms'] as List;
    List<AudioRoom> roomsList = list.map((i) => AudioRoom.fromJson(i)).toList();
    return RoomResponse(rooms: roomsList);
  }

  final List<AudioRoom> rooms;
}
