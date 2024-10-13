import 'package:audio_app/models/user.dart';

class AudioRoom {
  AudioRoom({
    required this.id,
    required this.name,
    this.capacity,
    Map<num, User>? users,
  }) : users = users ?? <num, User>{}; // Initialize users as an empty Map

  factory AudioRoom.fromJson(Map<String, dynamic> json) {
    return AudioRoom(
      id: num.parse(json['roomId']),
      name: json['name'] as String,
      capacity: json['capacity'] as int?,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .fold<Map<num, User>>({}, (map, user) {
            map[user.id] = user; // Add user to the map with user.id as key
            return map;
          }) ??
          <num, User>{}, // Initialize to an empty Map if null
    );
  }

  final num id;
  final String name;
  final int? capacity;
  final Map<num, User> users; // Change to Map

  AudioRoom copyWith({
    num? id,
    String? name,
    int? capacity,
    Map<num, User>? users, // Change to Map
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
      'users': users.values
          .map((user) => user.toJson())
          .toList(), // Convert Map values to List for JSON serialization
    };
  }
}
