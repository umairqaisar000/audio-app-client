class JoinRoomResponse {
  JoinRoomResponse({
    required this.message,
    required this.data,
    this.success,
  });

  factory JoinRoomResponse.fromJson(Map<String, dynamic> json) {
    return JoinRoomResponse(
      message: json['message'],
      data: json["data"],
      success: json['success'],
    );
  }
  final String message;
  final String data;
  final bool? success;
}
