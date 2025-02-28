import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/api_service.dart';
import 'package:stackture_mobile/utils/button.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/textfield.dart';
import 'package:stackture_mobile/utils/variables.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final GlobalKey<ShakingTextFieldState> _usernameTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _emailTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _passwordTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _confirmPasswordTfKey = GlobalKey<ShakingTextFieldState>();

  bool _isLoading = false;

  Future<void> _signUp() async {
    String username = _usernameTfKey.currentState!.getText();
    String email = _emailTfKey.currentState!.getText();
    String password = _passwordTfKey.currentState!.getText();
    String confirmPassword = _confirmPasswordTfKey.currentState!.getText();

    // Validate fields
    bool isValid = _usernameTfKey.currentState!.validateAndShake() &
    _emailTfKey.currentState!.validateAndShake() &
    _passwordTfKey.currentState!.validateAndShake() &
    _confirmPasswordTfKey.currentState!.checkIfMatch(password);

    if (!isValid) return;

    setState(() => _isLoading = true);

    try {
      final response = await ApiService().signup(username, email, password);

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Signup successful!"), backgroundColor: Colors.green)
        );
        Navigator.pop(context); // Navigate back after successful signup
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message']), backgroundColor: Colors.red)
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed. Try again."), backgroundColor: Colors.red)
      );
    }

    setState(() => _isLoading = false);
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
                      icon: const Icon(
                        Icons.cancel_outlined,
                        size: 40,
                        color: Colors.white,
                      )
                  ),
                )
              ],
            ),
            Image.asset("assets/images/books.png", width: 100, height: 100),
            const SizedBox(height: 20),
            Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 45, color: Colors.white, letterSpacing: 1.5,
                  fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                  shadows: defaultShadow
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 325,
                child: ShakingTextField(
                  key: _usernameTfKey,
                  label: 'Username',
                  hint: 'Enter Username',
                  errorText: 'Must input username',
                )
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 325,
                child: ShakingTextField(
                  key: _emailTfKey, type: TextInputType.emailAddress,
                  label: 'Email',
                  hint: 'Enter Email',
                  errorText: 'Must input email',
                )
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 325,
                child: ShakingTextField(
                  key: _passwordTfKey,
                  label: 'Password',
                  hint: 'Enter Password',
                  errorText: 'Must input password',
                )
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 325,
                child: ShakingTextField(
                  key: _confirmPasswordTfKey,
                  label: 'Confirm Password',
                  hint: 'Confirm Password',
                  errorText: 'Passwords must match',
                )
            ),
            const SizedBox(height: 20),
            DefaultButton(
              text: _isLoading ? "Submitting..." : "Submit",
              function: _isLoading ? null : _signUp,
            ),
          ],
        ),
      ),
    );
  }
}
