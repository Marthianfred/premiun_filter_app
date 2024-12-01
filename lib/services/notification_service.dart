import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:premium_filter/export.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  Future<NotificationBody?> activeNotification() async {
    NotificationBody? body;
    try {
      if (GetPlatform.isMobile) {
        final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
        if (remoteMessage != null) {
          if (kDebugMode) {
            print("este es el data del remote ${remoteMessage.data}");
          }
          body = NotificationHelper.convertNotification(remoteMessage.data);
        }
        await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
        FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
      }
    } catch (error) {
      if (kDebugMode) {
        print("error presente en notify ${error.toString()}");
      }
      activeNotification();
    }
    return body;
  }
}