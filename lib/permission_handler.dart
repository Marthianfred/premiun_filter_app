import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.notification,
      Permission.camera,

    ].request();

    if (statuses[Permission.notification]!.isGranted && statuses[Permission.camera]!.isGranted) {
      if (kDebugMode) {
        print('Los permisos fueron concedidos');
      }
    } else {
      if (kDebugMode) {
        print('Los permisos fueron denegados');
      }
    }
  }
}