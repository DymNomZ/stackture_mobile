import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/variables.dart';

class DefaultButton extends StatelessWidget {

  String text;
  Function? function;
  
  DefaultButton({super.key, required this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: StacktureColors.button,
        minimumSize: Size(250, 50),
        maximumSize: Size(250, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      onPressed: () {
        if(function != null) function!();
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13, color: Colors.white, letterSpacing: 1.5,
          fontWeight: FontWeight.bold, fontFamily: 'VarelaRound',
          shadows: defaultShadow
        ),
      ),
    );
  }
}