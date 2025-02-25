import 'package:flutter/material.dart';
import 'package:stackture_mobile/sign_in_page.dart';
import 'package:stackture_mobile/sign_up_page.dart';
import 'package:stackture_mobile/utils/button.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/variables.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.primary,
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 100),
            Image.asset(
              "assets/images/books.png",
              width: 100,
              height: 100,
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
            SizedBox(height: 80),
            DefaultButton(
              text: "Sign In", 
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
              },
            ),
            SizedBox(height: 10),
            DefaultButton(
              text: "Sign Up",
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}