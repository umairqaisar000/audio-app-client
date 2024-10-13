// lib/active_user_notifier.dart
import 'package:audio_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_user_notifier.g.dart';

@riverpod
class ActiveUserNotifier extends _$ActiveUserNotifier {
  @override
  List<User> build() {
    return [];
  }

  void addUser(User user) {
    state = [...state, user];
  }

  void removeUser(num id) {
    state = state.where((user) => user.id != id).toList();
  }

  void setUsers(List<User> users) {
    state = users;
  }

  void clearUsers() {
    state = [];
  }
}
