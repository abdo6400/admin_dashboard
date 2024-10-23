
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.subscribeToTopic("all");
    // String? token = await _firebaseMessaging.getToken();
    onForegroundMessage();
  }

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    // AdminApp.navigatorKey.currentState
    //     ?.pushNamed(Routes.notificationRoute, arguments: message.data['route']);
  }

  Future<void> onForegroundMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        handleMessage(message);
      }
    });
  }
}
