import 'package:flutter/material.dart';
import 'package:memo_hydrate/styles/assets_manager.dart';
import '../notifiche/bere_notifiche.dart';
import '../styles/interval_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeviTab extends StatefulWidget {
  const BeviTab({super.key});

  @override
  _BeviTabState createState() => _BeviTabState();
}

class _BeviTabState extends State<BeviTab> {
  int intervalloNotificheBere = 2; // Default value
  bool isSilent = false;
  final NotificationService notificationService;

  _BeviTabState() : notificationService = NotificationService(isSilentNotification: false);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadSavedInterval();
    _startNotificationLoop();
  }

  Future<void> _loadSavedInterval() async {
    final prefs = await SharedPreferences.getInstance();
    int savedInterval = prefs.getInt('notificationInterval') ?? 1;
    setState(() {
      intervalloNotificheBere = savedInterval;
      print('Loaded from shared prefs: $intervalloNotificheBere minute/s');
    });
  }

  Future<void> _saveInterval(int interval) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notificationInterval', interval);
    print('[MORENO]Saved to shared prefs: $interval minute/s');
  }

  void _startNotificationLoop() {
    // Start the notification loop with the specified interval
    notificationService.startNotificationLoop(intervalloNotificheBere);
    print('[MORENO]Notification interval for drinking: $intervalloNotificheBere minute/s');
  }

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
                  width: 100,
                  height: 100,
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
                print('[MORENO] Interval value changed to: $intervalloNotificheBere minute/s');
              });
            },
            onSavePressed: () async {
              // Stop the existing notification loop
              notificationService.stopNotificationLoop();
              print('[MORENO] You stopped the previous interval');

              // Start a new loop with the specified interval
              _startNotificationLoop();
              print('[MORENO]Notification interval for drinking: $intervalloNotificheBere minute/s');

              // Save the new interval
              await _saveInterval(intervalloNotificheBere);
              print('[MORENO] Interval saved: $intervalloNotificheBere minute/s');

              // Chiudi la tastiera
              FocusManager.instance.primaryFocus?.unfocus();
            },
            labelText: 'Ogni quanti minuti vuoi bere?',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Disattiva Suono notifica:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Checkbox(
                  activeColor: Colors.blueGrey,
                  splashRadius: 0,
                  checkColor: Colors.white,
                  value: isSilent,
                  onChanged: (value) {
                    setState(() {
                      notificationService.stopNotificationLoop();
                      isSilent = value ?? false; // Set isSilent to true if value is true, otherwise set it to false
                      print('[MORENO] Silent mode set to: $isSilent');
                      _startNotificationLoop();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
