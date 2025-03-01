import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/api_service.dart';
import 'package:stackture_mobile/utils/chat_popup.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/utils/workspace.dart';

class WorkspacePage extends StatefulWidget {

  Workspace workspace;

  WorkspacePage({super.key, required this.workspace});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.grid,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.workspace.title,
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
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GridPaper(
          color: Colors.white,
          divisions: 1,
          subdivisions: 8,
          interval: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              
            ],
          ),
        )
      ),
      floatingActionButtonLocation: FABLocation(),
      floatingActionButton: 
      FloatingActionButton(
        heroTag: "chat_btn",
        backgroundColor: StacktureColors.primary,
        child: Icon(Icons.chat_outlined, color: Colors.white),
        onPressed: () {
          if(ApiService().connectToAI(widget.workspace)){
            channel!.sink.add("Hello!");

            channel!.stream.listen(
              (message) {
                print('test: $message');
              }
            );
          }
          showDialog(
            context: context, 
            builder: (context) {
              return ChatPopup();
            }
          );
        }
      ),
    );
  }
}