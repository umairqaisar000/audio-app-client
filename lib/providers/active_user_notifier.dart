// lib/active_user_notifier.dart
import 'package:audio_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_user_notifier.g.dart';

@Riverpod(keepAlive: true)
class ActiveUserNotifier extends _$ActiveUserNotifier {
  @override
  List<User> build() {
    return [];
  }

  void setUsers(List<dynamic> activeUserData) {
    print(activeUserData);
    state = activeUserData.map((data) => User.fromJson(data)).toList();
  }
}
