import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pf_service/pf_service.dart';
import 'package:premium_filter/util/app_constants.dart';

class NotificationHelper {
  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse load) async {
      if (kDebugMode) {
        print("onDidReceiveNotificationResponse: ${load.toString()}");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showNotification(message, flutterLocalNotificationsPlugin, true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      try {
        if (/*message.data != null ||*/ message.data.isNotEmpty) {
          NotificationBody notificationBody = convertNotification(message.data);
          if (notificationBody.notificationType == NotificationType.order) {
            // Get.offAllNamed(RouteHelper.getOrderDetailsRoute(int.parse(message.data['order_id']), fromNotification: true));
          } else if (notificationBody.notificationType == NotificationType.general) {
            // Get.offAllNamed(RouteHelper.getNotificationRoute(fromNotification: true));
          } else {
            // Get.offAllNamed(RouteHelper.getChatRoute(notificationBody: notificationBody, conversationID: notificationBody.conversationId, fromNotification: true));
          }
        }
      } catch (_) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    await showTextNotification(message.notification!.title!, message.notification!.body!, convertNotification(message.data), fln);
  }

  String? getImageUrl(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return imageUrl.startsWith('http') ? imageUrl : '${AppConstants.baseUrl}/storage/app/public/notification/$imageUrl';
    }
    return null;
  }

  static Future<void> showTextNotification(String title, String body, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'premium_filter_informa',
      'premium_filter_informa',
      importance: Importance.max,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigTextNotification(String? title, String body, NotificationBody? notificationBody, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'premium_filter_informa',
      'premium_filter_informa',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      sound: const RawResourceAndroidNotificationSound('default'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static NotificationBody convertNotification(Map<String, dynamic> data) {
    if (data['type'] == 'general') {
      return NotificationBody(notificationType: NotificationType.general);
    } else if (data['type'] == 'order_status') {
      return NotificationBody(notificationType: NotificationType.order, orderId: int.parse(data['order_id']));
    } else {
      return NotificationBody(
        notificationType: NotificationType.message,
      );
    }
  }

  static Future<void> showNotificationWithButtons(String? title, String? body, FlutterLocalNotificationsPlugin fln) async {
// Define los botones de acción
    List<AndroidNotificationAction> actions = <AndroidNotificationAction>[
      const AndroidNotificationAction(
        'action_id_1',
        'Botón 1',
      ),
      const AndroidNotificationAction(
        'action_id_2',
        'Botón 2',
      ),
    ];

// Define el estilo de la notificación
    MediaStyleInformation mediaStyleInformation = const MediaStyleInformation(
      htmlFormatTitle: true,
      htmlFormatContent: true,
    );

// Define los detalles de la notificación
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'premium_filter_informa',
      'premium_filter_informa',
      importance: Importance.max,
      priority: Priority.max,
      styleInformation: mediaStyleInformation,
      actions: actions,
      // Agrega los botones de acción
      sound: const RawResourceAndroidNotificationSound('default'),
    );

// Define los detalles de la notificación
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

// Muestra la notificación
    await fln.show(0, title, body, platformChannelSpecifics);
  }
}

@pragma("vm:entry-point")
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("onBackground: $message");
  }

  var androidInitialize = const AndroidInitializationSettings('notification_icon');
  var iOSInitialize = const DarwinInitializationSettings();
  var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}

class PayloadModel {
  PayloadModel({
    this.title,
    this.body,
    this.orderId,
    this.image,
    this.type,
  });

  String? title;
  String? body;
  String? orderId;
  String? image;
  String? type;

  factory PayloadModel.fromRawJson(String str) => PayloadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        title: json["title"],
        body: json["body"],
        orderId: json["order_id"],
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "order_id": orderId,
        "image": image,
        "type": type,
      };
}
