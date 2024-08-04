import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xfff8acff),
              Color(0xff696eff),
            ],
          ),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹",
              style: TextStyle(fontSize: 180),
            ),
            Text(
              "Fake Currency Detection.",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text("- by Moinak Majumdar, MCA, 2024")
          ],
        ),
      ),
    );
  }
}
