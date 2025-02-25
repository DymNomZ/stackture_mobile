import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/button.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/textfield.dart';
import 'package:stackture_mobile/utils/variables.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin{

  final GlobalKey<ShakingTextFieldState> _usernameTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _passwordTfKey = GlobalKey<ShakingTextFieldState>();
  
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 40,
                      color: Colors.white,
                    )
                  ),
                )
              ],
            ),
            Image.asset(
              "assets/images/books.png",
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 45, color: Colors.white, letterSpacing: 1.5,
                fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                shadows: defaultShadow
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 325,
              child: ShakingTextField(
                key: _usernameTfKey,
                label: 'Username',
                hint: 'Enter Username',
                errorText: 'Must input username',
              )
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 325,
              child: ShakingTextField(
                key: _passwordTfKey,
                label: 'Password',
                hint: 'Enter Password',
                errorText: 'Must input password',
              )
            ),
            SizedBox(height: 20),
            DefaultButton(
              text: "Submit", 
              function: () {
                _usernameTfKey.currentState?.validateAndShake();
                _passwordTfKey.currentState?.validateAndShake();
              }
            ),
          ],
        ),
      ),
    );
  }
}