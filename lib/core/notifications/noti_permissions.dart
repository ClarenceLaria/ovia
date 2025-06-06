// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestNotificationPermission() async {
  if (await Permission.notification.isDenied ||
      await Permission.notification.isRestricted ||
      await Permission.notification.isPermanentlyDenied) {
    await Permission.notification.request();
  }
}
