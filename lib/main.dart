import 'package:flutter/material.dart';
import 'package:memo_hydrate/modules/splashscreen.dart';
import 'package:memo_hydrate/styles/bottomnav.dart';
import 'package:permission_handler/permission_handler.dart';
import 'notifiche/bere_notifiche.dart';
import 'tabs/bevi_tab.dart';
import 'tabs/alzati_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService(isSilentNotification: false).initNotification();
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}

class MyTabs extends StatefulWidget {
  const MyTabs({Key? key}) : super(key: key);

  @override
  _MyTabsState createState() => _MyTabsState();
}

class _MyTabsState extends State<MyTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTabContent(_selectedIndex),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestNotificationPermission(context); // Richiedi l'autorizzazione alle notifiche
  }

  Future<void> _requestNotificationPermission(BuildContext context) async {
    if (!(await Permission.notification.isGranted)) {
      // Se le notifiche sono disattivate, richiedi l'autorizzazione
      var status = await Permission.notification.request();
      if (status.isDenied) {
        // L'utente ha rifiutato l'autorizzazione, puoi mostrarli un messaggio o reindirizzarli alle impostazioni
        _showPermissionDeniedDialog(context);
      }
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Autorizzazione notifiche richiesta'),
          content: const Text('Per ricevere le notifiche, attiva l\'autorizzazione nelle impostazioni dell\'app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Chiudi'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings(); // Apre le impostazioni dell'app
              },
              child: const Text('Apri Impostazioni'),
            ),
          ],
        );
      },
    );
  }


  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return const BeviTab();
      case 1:
        return const AlzatiTab();
      default:
        return const SizedBox.shrink();
    }
  }
}
