import 'package:flutter/material.dart';

import '../notifiche/bere_notifiche.dart';

class AlzatiTab extends StatelessWidget {
  const AlzatiTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
          child: ElevatedButton(
            child: const Text('Show notifications'),
            onPressed: () {
              },
          )),
    );
  }
}
