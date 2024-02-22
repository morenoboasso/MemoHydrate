import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future<void> setNotificationCooldown(int cooldownMinutes) async {
    // Cancella tutte le notifiche attualmente pianificate
    //await notificationsPlugin.cancelAll();

    // Calcola il prossimo orario per la notifica
    DateTime nextNotificationTime =
    DateTime.now().add(Duration(minutes: cooldownMinutes));

    // Pianifica la notifica
    await notificationsPlugin.schedule(
      0, // ID notifica
      'BMemo Hydrate', // Titolo notifica
      'È il momento di bere un po\' d\'acqua!', // Testo notifica
      nextNotificationTime, // Orario in cui visualizzare la notifica
      await notificationDetails(), // Dettagli notifica
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }
}
