import 'package:flutter/material.dart';
import 'package:parallax_rain/parallax_rain.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          backgroundColor: Colors.blueGrey,
          iconSize: 20,
          elevation: 10,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink),
              label: 'Bevi un pò',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new),
              label: 'Alzati un pò',
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: selectedIndex == 0 ? 0 : null,
          right: selectedIndex == 1 ? 0 : null,
              child: ParallaxRain(
            numberOfDrops: 3,
            dropFallSpeed: 1.0,
            dropHeight: 2,
            dropWidth: 1,
            dropColors: const [Colors.blueAccent, Colors.lightBlueAccent],
            trail: true,
            rainIsInBackground: true,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
            ),
          )
        ),
      ],
    );
  }
}
