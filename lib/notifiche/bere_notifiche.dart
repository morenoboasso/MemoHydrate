import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Timer per il loop periodico delle notifiche
  late Timer _notificationTimer;
  final bool isSilentNotification; // Add isSilent as a parameter


  NotificationService({required this.isSilentNotification}) {
    // Inizializza il timer con una durata vuota all'avvio
    _notificationTimer = Timer(Duration.zero, () {});
  }
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('flutter_logo');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null, // Disabilita iOS
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );
  }

  // Funzione per iniziare il loop delle notifiche
  void startNotificationLoop(int intervalMinutes) {
    // Cancella il timer esistente prima di avviare uno nuovo
    _notificationTimer.cancel();

    _notificationTimer = Timer.periodic(
      Duration(minutes: intervalMinutes),
          (Timer timer) {
        _sendNotification(); // Invia una notifica ogni tot minuti
            debugPrint("Notifica mandata");
      },
    );
  }


  // Funzione per inviare la notifica
  Future<void> _sendNotification() async {
    DateTime now = DateTime.now();

    // Definisci il colore desiderato
    Color notificationColor = Colors.lightBlue; // Utilizza il colore bluegrey

    // Invia la notifica con l'aspetto personalizzato
    await notificationsPlugin.show(
      0, // ID notifica
      '❄️ Memo Hydrate ❄️', // Titolo notifica
      'È il momento di bere un po\' d\'acqua! 💧', // Testo notifica
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
          silent: isSilentNotification!,
          priority: Priority.max,
          styleInformation: const BigTextStyleInformation(''),
          color: notificationColor,
        ),
      ),
    );
  }


  // Funzione per fermare il loop delle notifiche
  void stopNotificationLoop() {
    _notificationTimer.cancel();
  }
}