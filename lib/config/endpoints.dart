enum Environment {
  local,
  localIP,
}

class Endpoints {
  static Environment currentEnvironment = Environment.localIP;

  static String get url {
    switch (currentEnvironment) {
      case Environment.local:
        return 'http://127.0.0.1:3000';
      case Environment.localIP:
        return 'http://192.168.1.10:3000';
    }
  }

  static String get socketUrl {
    switch (currentEnvironment) {
      case Environment.local:
        return 'http://127.0.0.1:3000';
      case Environment.localIP:
        return 'http://192.168.1.10:3000';
      default:
        return 'ws://localhost:3000';
    }
  }

  static String baseUrl = url;
  static String baseSocketUrl = socketUrl;
  static const liveKitSfuUrl = 'http://192.168.1.10:7880';
}
