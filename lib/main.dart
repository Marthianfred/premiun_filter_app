import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:premium_filter/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:premium_filter/filters.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart' as di;
import 'services/notification_service.dart';
import 'helper/http_overrides.dart';
import 'package:pf_service/pf_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kDebugMode) {
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  Map<String, Map<String, String>> languages = await di.init();
  HttpOverrides.global = MyHttpOverrides();

  NotificationBody? body = await NotificationService(flutterLocalNotificationsPlugin).activeNotification();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(FiltersAPP(
    languages: languages,
    body: body,
    prefs: Get.find(),
  ));
}