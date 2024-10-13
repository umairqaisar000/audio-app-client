import 'package:audio_app/models/user.dart';

class AudioRoom {
  AudioRoom({
    required this.id,
    required this.name,
    this.capacity,
    this.users = const [],
  });

  factory AudioRoom.fromJson(Map<String, dynamic> json) {
    return AudioRoom(
      id: num.parse(json['roomId']),
      name: json['name'] as String,
      capacity: json['capacity'] as int?,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  final num id;
  final String name;
  final int? capacity;
  final List<User> users;

  AudioRoom copyWith({
    num? id,
    String? name,
    int? capacity,
    List<User>? users,
  }) {
    return AudioRoom(
      id: id ?? this.id,
      name: name ?? this.name,
      capacity: capacity ?? this.capacity,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': id,
      'name': name,
      'capacity': capacity,
      'users': users,
    };
  }
}
