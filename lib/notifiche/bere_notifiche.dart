import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  late Timer _notificationTimer;
  int _notificationIdCounter = 0;

  NotificationService() {
    _notificationTimer = Timer(Duration.zero, () {});
  }
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('flutter_logo');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  // Funzione per iniziare il loop delle notifiche
  void startNotificationLoop(int intervalMinutes, bool notificationSound) {
    // Cancella il timer esistente prima di avviare uno nuovo
    _notificationTimer.cancel();

    _notificationTimer = Timer.periodic(
      Duration(minutes: intervalMinutes),
          (Timer timer) {
        _sendNotification(notificationSound, timer.tick);
        debugPrint(
            "[MORENO - bere_notifiche] Notifica mandata");
      },
    );
  }

  Future<void> _sendNotification(bool notificationSound, int tick) async {
    // Incrementa il contatore prima di utilizzarlo come ID univoco per la notifica
    _notificationIdCounter++;

    // Messaggio di debug con ID della notifica
    debugPrint(
        '[MORENO - bere_notifiche] Notifica mandata id:$_notificationIdCounter con sound ${notificationSound ? 'enabled' : 'disabled'}');

    // Imposta un canale univoco per ogni notifica
    String channelId = 'channelId_$_notificationIdCounter';

    await notificationsPlugin.show(
      _notificationIdCounter, // Utilizza il nuovo ID notifica
      '❄️ Memo Hydrate ❄️',
      'È il momento di bere un po\' d\'acqua! 💧',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'channelName',
          importance: Importance.max,
          priority: Priority.max,
          styleInformation: const BigTextStyleInformation(''),
          playSound: notificationSound ? true : false,
          sound: notificationSound
              ? const RawResourceAndroidNotificationSound('glass')
              : const RawResourceAndroidNotificationSound('silent'),
          enableVibration: true,
          vibrationPattern: Int64List.fromList([500, 500, 500]),
        ),
      ),
    );
  }


  // Funzione per fermare il loop delle notifiche
  void stopNotificationLoop() {
    _notificationTimer.cancel();
  }
}