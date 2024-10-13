import 'package:audio_app/config/endpoints.dart';
import 'package:audio_app/models/user.dart';
import 'package:audio_app/providers/rooms_notifier.dart';
import 'package:audio_app/providers/user_notifier.dart';
import 'package:audio_app/utils/app_data.dart';
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
      print('connected to SOCKET');
    });

    socket.on('disconnected', (_) {
      print('disconnected');
      AppProviderContainer.instance
          .read(userNotifierProvider.notifier)
          .clearUser();
    });

    socket.on("userInfo", (data) {
      print("USER INFO");

      AppProviderContainer.userData = User(id: data['id'], name: data['name']);
      AppProviderContainer.instance
          .read(userNotifierProvider.notifier)
          .updateUser(data['id'], data['name']);
    });

    socket.on("roomsUserInfo", (data) {
      print("ROOM INFO");
      print(data);
      AppProviderContainer.instance
          .read(roomsNotifierProvider.notifier)
          .updateRooms(data);
    });

    socket.on("userJoined", (data) {
      AppProviderContainer.instance
          .read(roomsNotifierProvider.notifier)
          .userJoinedRoom(data['roomId'], data['userId']);
    });

    socket.on("roomLeft", (data) {
      AppProviderContainer.instance
          .read(roomsNotifierProvider.notifier)
          .userLeftRoom(data['roomId'], data['userId']);
    });

    socket.on("userDisconnected", (data) {
      AppProviderContainer.instance
          .read(roomsNotifierProvider.notifier)
          .userDisconnected(data['userId']);
    });
  }

  static void joinRoom(int roomId) {
    socket.emit('joinRoom', {'roomId': roomId});
  }

  static void leaveRoom(int roomId) {
    socket.emit('leaveRoom', {'roomId': roomId});
  }
}
