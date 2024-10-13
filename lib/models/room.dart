class Room {
  Room({
    this.id,
    this.name,
    this.capacity,
    this.users = const [],
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as num?,
      name: json['name'] as String?,
      capacity: json['capacity'] as int,
      users: (json['users'] as List<dynamic>?)?.map((e) => e as num).toList() ??
          [],
    );
  }

  final num? id;
  String? name;
  final int? capacity;
  final List<num> users;

  Room copyWith({
    num? id,
    String? name,
    int? capacity,
    List<num>? users,
  }) {
    return Room(
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
