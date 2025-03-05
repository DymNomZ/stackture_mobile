import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';

class NodePopup extends StatefulWidget {

  Map<String, dynamic>? node;

  NodePopup({super.key, required this.node});

  @override
  State<NodePopup> createState() => _NodePopupState();
}

class _NodePopupState extends State<NodePopup> {
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: StacktureColors.popup,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, size: 20, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    widget.node?['summary'] ?? "no description ❔",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'LilitaOne',
                    ),
                    speed: Duration(milliseconds: 40),
                  ),
                ],
                repeatForever: false, // Plays only once
                totalRepeatCount: 1,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}