import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/variables.dart';

class DefaultButton extends StatelessWidget {

  String text;
  Function? function;
  double? width;
  Color? color;
  
  DefaultButton({
    super.key, required this.text, this.function, 
    this.width, this.color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? StacktureColors.button,
        minimumSize: Size(width ?? 250, 50),
        maximumSize: Size(width ?? 250, 50),
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