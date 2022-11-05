import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService();

  final _notificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androindInitSettings =
    AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings settings = InitializationSettings(
        android: androindInitSettings, iOS: initializationSettingsDarwin);

    await _notificationService.initialize(settings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  Future<void> showScheduledNotification(
      {required int id, required String title, required String body, required DateTime dateTime}) async {
    final details = await _notificationDetails();
    await _notificationService.zonedSchedule(
        id, title, body, tz.TZDateTime.from(dateTime, tz.local), details,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
            .absoluteTime, androidAllowWhileIdle: true);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'channel_name');
    const DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails();
    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body,
      String? payload) {
    if (kDebugMode) {
      print('id $id');
    }
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }
}
