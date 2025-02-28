import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';

class WorkspacePage extends StatefulWidget {

  String title;

  WorkspacePage({super.key, required this.title});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 20, color: Colors.white, letterSpacing: 1.5,
              fontWeight: FontWeight.bold, fontFamily: 'LilitaOne'
          ),
        ),
        backgroundColor: StacktureColors.primary,
        leading: IconButton(
          icon: Icon(Icons.home_outlined, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FABLocation(),
      floatingActionButton: 
      FloatingActionButton(
        heroTag: "chat_btn",
        backgroundColor: StacktureColors.primary,
        child: Icon(Icons.chat_outlined, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return Placeholder();
            }
          );
        }
      ),
    );
  }
}