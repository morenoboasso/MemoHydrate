import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memo_hydrate/styles/assets_manager.dart';
import 'package:parallax_rain/parallax_rain.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyTabs(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsHD.background),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ParallaxRain(
            numberOfDrops: 30,
            dropFallSpeed: 2.0,
            dropHeight: 5,
            dropWidth: 2,
            dropColors: const [Colors.blueAccent, Colors.lightBlueAccent],
            trail: true,
            rainIsInBackground: true,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsHD.logo,
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Memo Hydrate',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),  // Spazio aggiunto tra il titolo e il sottotitolo
                     Text(
                      ' Ricordati di bere!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        shadows: [
                          Shadow(
                            offset: const Offset(1.0, 2.0),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 142),  // Regolato lo spazio tra il sottotitolo e il CircularProgressIndicator
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                      backgroundColor: Colors.lightBlue,
                      strokeWidth: 6.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
