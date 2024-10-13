enum Environment { local, localIP }

class Endpoints {
  static Environment currentEnvironment = Environment.local;

  static String get url {
    switch (currentEnvironment) {
      case Environment.local:
        return 'http://127.0.0.1:3000';
      case Environment.localIP:
        return "http://192.168.100.114:3000";
    }
  }

  static String get socketUrl {
    switch (currentEnvironment) {
      case Environment.local:
        return 'http://127.0.0.1:3000';
      case Environment.localIP:
        return 'http://192.168.100.114:3000';
      default:
        return 'ws://localhost:3000';
    }
  }

  static String baseUrl = url;
  static String baseSocketUrl = socketUrl;
  static const liveKitSfuUrl = 'ws://192.168.100.222:7880';
}
