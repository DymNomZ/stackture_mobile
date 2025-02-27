import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/auth_page.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/books.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Stackture",
              style: TextStyle(
                fontSize: 45, color: Colors.white, letterSpacing: 1.5,
                fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                shadows: defaultShadow
              ),
            ),
            Text(
              "Structure Your Stack",
              style: TextStyle(
                fontSize: 18, color: Colors.white, letterSpacing: 1.5,
                fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                shadows: defaultShadow
              ),
            ),
          ],
        ),
      ),
    );
  }
}