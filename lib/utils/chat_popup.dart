import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/utils/workspace.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatPopup extends StatefulWidget {

  Workspace workspace;

  ChatPopup({super.key, required this.workspace});

  @override
  State<ChatPopup> createState() => _ChatPopupState();
}

class _ChatPopupState extends State<ChatPopup> {
  
  final TextEditingController _controller = TextEditingController();
  String _response = "";
  WebSocketChannel? channel;

   /// AI Chat API
  void connectToAI() {

    channel = WebSocketChannel.connect(
      Uri.parse('ws://stackture.eloquenceprojects.org/chat'),
    );

    // Send the handshake message
    final handshakeMessage = {
      "workspace_id": widget.workspace.id,
      "node_id": 0,
      "token": token,
    };

    channel!.sink.add(jsonEncode(handshakeMessage));

    setState(() {
      _response = 'loading...';
    });

    channel!.stream.listen(
      (message) {

        //For executing handshake initially
        try {
          final jsonResponse = jsonDecode(message);
          if (jsonResponse['status'] == 'success') {
            
            print('Handshake successful: ${jsonResponse['message']}');

            //chat proper
            setState(() {
              _response = jsonResponse['message'];
            });

          } else {
            print('Handshake failed: ${jsonResponse['message']}');
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
        
      },
      onDone: () {
        print('WebSocket connection closed.');
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      
    );

  }

  void sendMessage() {
    
    String prompt = _controller.text.trim();
    if (prompt.isEmpty) return;

    setState(() {
      _response = "Loading...";
    });

    channel!.sink.add(prompt);
    
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    connectToAI();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 700,
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
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Hello!',
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'LilitaOne',
                  ),
                  speed: Duration(milliseconds: 80),
                ),
              ],
              repeatForever: false, // Plays only once
              totalRepeatCount: 1,
            ),

            SizedBox(height: 10),

            // Chat Display
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Text(
                    _response,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            // Input Field & Send Button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Ask me anything!",
                        hintStyle: TextStyle(color: Colors.white70, fontFamily: 'LilitaOne'),
                        filled: true,
                        fillColor: Colors.black12,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
