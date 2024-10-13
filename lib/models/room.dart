import 'package:audio_app/models/user.dart';

class AudioRoom {
  AudioRoom({
    this.id,
    this.name,
    this.capacity,
    this.users = const [],
  });

  factory AudioRoom.fromJson(Map<String, dynamic> json) {
    return AudioRoom(
      id: json['id'] as num?,
      name: json['name'] as String?,
      capacity: json['capacity'] as int?,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as User).toList() ??
              [],
    );
  }

  final num? id;
  String? name;
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
      'id': id,
      'name': name,
      'capacity': capacity,
      'users': users,
    };
  }
}
