// lib/user_notifier.dart
import 'package:audio_app/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    return null;
  }

  void updateUser(num id, String name) {
    state = User(id: id, name: name);
  }

  void clearUser() {
    state = null;
  }
}
