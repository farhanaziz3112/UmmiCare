import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notificationService {

  Future<void> init(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future selectNotification(String payload) async {}

  static final notificationService _notificationService =
      notificationService._internal();

  factory notificationService() {
    return _notificationService;
  }

  notificationService._internal();

  Future showNotification(
      {var id,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        new AndroidNotificationDetails(title, body,
            playSound: true, importance: Importance.max, priority: Priority.high);

    var noti = NotificationDetails(android: androidPlatformChannelSpecifics);

    await fln.show(id, title, body, noti);
  }
}


// const NotificationDetails platformChannelSpecifics = 
//   NotificationDetails(android: androidPlatformChannelSpecifics);