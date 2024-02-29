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
  late TextEditingController intervalController;
  final NotificationService notificationService;
  int intervalloNotificheBere = 20;
  bool notificationSound = true;
  bool serviceActive = true;
  _BeviTabState() : notificationService = NotificationService();

  Future<void> _loadSavedSwitchesState() async {
    final prefs = await SharedPreferences.getInstance();
    bool savedNotificationSound = prefs.getBool('notificationSound') ?? true;
    bool savedServiceActive = prefs.getBool('serviceActive') ?? true;
    setState(() {
      notificationSound = savedNotificationSound;
      serviceActive = savedServiceActive;
      debugPrint('[MORENO SHARED PREF] Loaded switches state from shared prefs');
    });
  }
  Future<void> _saveSwitchesState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationSound', notificationSound);
    await prefs.setBool('serviceActive', serviceActive);
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
    intervalController =
        TextEditingController(text: intervalloNotificheBere.toString());
    _loadSavedSwitchesState(); // Load switches state on initialization
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
      intervalController.text = savedInterval.toString();
      debugPrint('[MORENO SHARED PREF] Loaded from shared prefs: $intervalloNotificheBere minute/s');
    });
  }

  Future<void> _saveInterval(int interval) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notificationInterval', interval);
    debugPrint('[MORENO BEVI_TAB]Saved to shared prefs: $interval minute/s');
  }

  void _startNotificationLoop() {
    if (serviceActive) {
      notificationService.startNotificationLoop(
          intervalloNotificheBere, notificationSound);
      debugPrint(
          '[MORENO BEVI_TAB]Notification interval started for drinking: $intervalloNotificheBere minute/s');
    } else {
      notificationService.stopNotificationLoop();
      debugPrint('[MORENO BEVI_TAB]Notification loop stopped');
    }
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
                debugPrint(
                    '[MORENO BEVI_TAB]Interval value changed to: $intervalloNotificheBere minute/s');
              });
            },
            onSavePressed: () async {
              // Stop the existing notification loop
              notificationService.stopNotificationLoop();
              debugPrint('[MORENO BEVI_TAB]You stopped the previous interval');

              // Start a new loop with the specified interval and sound state
              _startNotificationLoop();

              // Save the new interval
              await _saveInterval(intervalloNotificheBere);
              debugPrint('[MORENO BEVI_TAB]Interval saved: $intervalloNotificheBere minute/s');


              // Chiudi la tastiera
              FocusManager.instance.primaryFocus?.unfocus();
            },
            labelText: 'Ogni quanti minuti vuoi bere?',
            intervalController: intervalController, // Pass intervalController to IntervalInput
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 60, right: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Suono notifica:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          notificationSound ? Icons.volume_up : Icons.volume_off,
                          color: notificationSound ? Colors.blueGrey : Colors.grey,
                        ),
                        Switch(
                          activeTrackColor: Colors.blueGrey,
                          value: notificationSound,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                          thumbColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.dragged)) {
                                return Colors.blueGrey;
                              }
                              return notificationSound
                                  ? Colors.white
                                  : Colors.white;
                            },
                          ),
                          onChanged: (value) {
                            setState(() {
                              notificationSound = value;
                            });

                            // Stop the existing notification loop
                            notificationService.stopNotificationLoop();
                            debugPrint(
                                '[MORENO BEVI_TAB]You stopped the previous interval');

                            // Start a new loop with the specified interval and sound state
                            _startNotificationLoop();
                            debugPrint(
                                '[MORENO BEVI_TAB]Notification interval for drinking: $intervalloNotificheBere minute/s');

                            debugPrint(
                                '[MORENO BEVI_TAB] Sound notification is ${notificationSound ? 'enabled' : 'disabled'}');
                            _saveSwitchesState(); // Save switches state when it changes

                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifiche:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          serviceActive ? Icons.notifications : Icons.notifications_off,
                          color: serviceActive ? Colors.blueGrey : Colors.grey,
                        ),
                        Switch(
                          activeTrackColor: Colors.blueGrey,
                          value: serviceActive,
                          inactiveTrackColor: Colors.grey,
                          inactiveThumbColor: Colors.white,
                          thumbColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.dragged)) {
                                return Colors.blueGrey;
                              }
                              return serviceActive ? Colors.white : Colors.white;
                            },
                          ),
                          onChanged: (value) {
                            setState(() {
                              serviceActive = value;
                            });
                            notificationService.stopNotificationLoop();
                            _startNotificationLoop();
                            _saveSwitchesState(); // Save switches state when it changes

                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
