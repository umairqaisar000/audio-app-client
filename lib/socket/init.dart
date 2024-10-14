import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/providers/active_user_notifier.dart';
import 'package:audio_app/providers/rooms_notifier.dart';
import 'package:audio_app/providers/user_notifier.dart';
import 'package:audio_app/utils/app_data.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketManager {
  static late io.Socket socket;
  static bool isSocketInitialized = false;

  static void initSocket() {
    socket = io.io(Endpoints.baseSocketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
    isSocketInitialized = true;

    socket.on('connected', (_) {
      debugPrint('connected to SOCKET');
    });

    socket.on("userInfo", (data) {
      debugPrint("USER INFO");
      AppProviderContainer.instance
          .read(userNotifierProvider.notifier)
          .updateUser(data['id'], data['name']);
    });

    socket.on('allUsers', (data) {
      AppProviderContainer.instance
          .read(activeUserNotifierProvider.notifier)
          .setUsers(data);
    });

    socket.on("roomsUserInfo", (data) {
      debugPrint("ROOM INFO");
      debugPrint(data.toString());
      AppProviderContainer.instance
          .read(roomsNotifierProvider.notifier)
          .updateRooms(data);
    });
  }

  static void joinRoom(int roomId) {
    socket.emit('joinRoom', {'roomId': roomId});
  }

  static void leaveRoom(int roomId) {
    socket.emit('leaveRoom', {'roomId': roomId});
  }
}
