import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    bool previousConnection = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        previousConnection = true;
      } else {
        previousConnection = false;
      }
    } on SocketException catch (_) {
      previousConnection = false;
    }
    return previousConnection;
  }
}
