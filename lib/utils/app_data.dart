import 'package:audio_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppProviderContainer {
  static final ProviderContainer instance = ProviderContainer();
  static num? currentRoomId;
  static User? userData;
}
