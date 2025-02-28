import 'package:flutter/material.dart';
import 'package:stackture_mobile/home_page.dart';
import 'package:stackture_mobile/utils/button.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/textfield.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/utils/api_service.dart'; // Import API service

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ShakingTextFieldState> _usernameTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _passwordTfKey = GlobalKey<ShakingTextFieldState>();

  final ApiService apiService = ApiService();
  bool isLoading = false;
  String? errorMessage;

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    String username = _usernameTfKey.currentState!.getText();
    String password = _passwordTfKey.currentState!.getText();


    final response = await apiService.login(username, password);

    setState(() {
      isLoading = false;
    });

    if (response.containsKey("token")) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        errorMessage = response["error"];
      });
    }
  }

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
                  // obscureText: true,
                )
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            SizedBox(height: 10),
            isLoading
                ? CircularProgressIndicator()
                : DefaultButton(
              text: "Submit",
              function: () {
                if (_usernameTfKey.currentState!.validateAndShake() &&
                    _passwordTfKey.currentState!.validateAndShake()) {
                  _handleLogin();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
