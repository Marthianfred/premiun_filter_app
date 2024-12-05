import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<void> requestPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.notification,
      ].request();

      bool allGranted = true;
      statuses.forEach((permission, status) {
        if (status.isDenied || status.isPermanentlyDenied) {
          allGranted = false;
          if (kDebugMode) {
            print('Permission for $permission was denied or permanently denied');
          }
        } else if (status.isGranted && kDebugMode) {
          debugPrint('Permission for $permission was granted');
        }
      });

      if (!allGranted) {
        if (kDebugMode) {
          print('Not all permissions were granted. Prompting user to grant permissions again.');
        }
        await _handleDeniedPermissions(statuses);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while requesting permissions: $e');
      }
    }
  }

  Future<void> _handleDeniedPermissions(Map<Permission, PermissionStatus> statuses) async {
    for (var entry in statuses.entries) {
      if (entry.value.isPermanentlyDenied) {
        if (kDebugMode) {
          print('Opening app settings for permission: ${entry.key}');
        }
        await openAppSettings();
      } else if (entry.value.isDenied) {
        if (kDebugMode) {
          print('Re-requesting permission: ${entry.key}');
        }
        await entry.key.request();
      }
    }
  }
}