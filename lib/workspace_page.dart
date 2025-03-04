import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/chat_popup.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';
import 'package:stackture_mobile/utils/tree_screen.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            centerTitle: true,
            title: Text(
              widget.workspace.title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LilitaOne'),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Image.asset(
                ""
                "assets/images/left.png",
                width: 20,
                height: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(context);
              },
            ),
          ),
        ),
      ),
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GridPaper(
            color: Colors.white,
            divisions: 1,
            subdivisions: 4,
            interval: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: TreeScreen(workspace: widget.workspace))
              ],
            ),
          )),
      floatingActionButtonLocation: FABLocation(),
      floatingActionButton: FloatingActionButton(
          heroTag: "chat_btn",
          backgroundColor: StacktureColors.primary,
          child: Image.asset(
            ""
            "assets/images/chatbot.png",
            width: 30,
            height: 30,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ChatPopup(workspace: widget.workspace);
              },
            );
          }),
    );
  }
}
