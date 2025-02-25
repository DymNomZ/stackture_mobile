import 'package:flutter/material.dart';
import 'package:stackture_mobile/recent_activity_panel.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _showRecent = false; // Controls recent activity visibility

  void toggleRecent() {
    setState(() {
      _showRecent = !_showRecent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),

      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "What would you like to learn today?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),

          RecentActivityPanel(isVisible: _showRecent),

          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 10,
            left: _showRecent ? 170 : 10,
            child: FloatingActionButton(
              onPressed: toggleRecent,
              child: Icon(_showRecent ? Icons.close : Icons.history),
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),

      backgroundColor: Colors.blue.shade100,
    );
  }
}
