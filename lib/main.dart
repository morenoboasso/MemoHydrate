import 'package:flutter/material.dart';
import 'package:memo_hydrate/modules/splashscreen.dart';
import 'package:memo_hydrate/styles/bottomnav.dart';
import 'tabs/bevi_tab.dart';
import 'tabs/alzati_tab.dart';

void main() {
  runApp(const MaterialApp(
    home: MyTabs(),
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
