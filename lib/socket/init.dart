import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/providers/rooms_notifier.dart';
import 'package:audio_app/providers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static late io.Socket socket;
  static bool isSocketInitialized = false;

  static void initSocket(WidgetRef ref) {
    socket = io.io(Endpoints.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    isSocketInitialized = true;

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('disconnect', (_) {
      print('disconnected');
      ref.read(userNotifierProvider.notifier).clearUser();
    });

    socket.on("userInfo", (data) {
      ref
          .read(userNotifierProvider.notifier)
          .updateUser(data['id'], data['name']);
    });

    socket.on("roomsUserInfo", (data) {
      ref.read(roomsNotifierProvider.notifier).updateRooms(data);
    });

    socket.on("userJoined", (data) {
      ref
          .read(roomsNotifierProvider.notifier)
          .userJoinedRoom(data['roomId'], data['userId']);
    });

    socket.on("roomLeft", (data) {
      ref
          .read(roomsNotifierProvider.notifier)
          .userLeftRoom(data['roomId'], data['userId']);
    });

    socket.on("userDisconnected", (data) {
      ref.read(roomsNotifierProvider.notifier).userDisconnected(data['userId']);
    });
  }

  static void joinRoom(int roomId) {
    socket.emit('joinRoom', {'roomId': roomId});
  }

  static void leaveRoom(int roomId) {
    socket.emit('leaveRoom', {'roomId': roomId});
  }
}
