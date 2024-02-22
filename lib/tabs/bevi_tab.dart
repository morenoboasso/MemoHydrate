import 'package:flutter/material.dart';
import 'package:memo_hydrate/styles/assets_manager.dart';
import '../notifiche/bere_notifiche.dart';
import '../styles/interval_input.dart';

class BeviTab extends StatefulWidget {
  const BeviTab({Key? key}) : super(key: key);

  @override
  _BeviTabState createState() => _BeviTabState();
}

class _BeviTabState extends State<BeviTab> {
  int intervalloNotificheBere = 30;
  final NotificationService notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  AssetsHD.logo,
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Bevi un po d\'acqua',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(height: 40),
          IntervalInput(
            intervalloNotificheBere: intervalloNotificheBere,
            onIntervalChanged: (value) {
              setState(() {
                intervalloNotificheBere = int.tryParse(value) ?? 0;
              });
            },
            onSavePressed: () {
              print('Intervallo notifiche bere: $intervalloNotificheBere minuti');
              notificationService.setNotificationCooldown(intervalloNotificheBere);
            },
            labelText: 'Ogni quanto vuoi bere? ⏳ ',
          ),
        ],
      ),
    );
  }
}
