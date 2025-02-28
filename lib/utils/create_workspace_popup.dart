import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/button.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/textfield.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/utils/workspace.dart';
import 'package:stackture_mobile/workspace_page.dart';

class CreateWorkspacePopup extends StatefulWidget {

  Function callBack;

  CreateWorkspacePopup({super.key, required this.callBack});

  @override
  State<CreateWorkspacePopup> createState() => _CreateWorkspacePopupState();
}

class _CreateWorkspacePopupState extends State<CreateWorkspacePopup> {
  final GlobalKey<ShakingTextFieldState> _workspaceNameTfKey = GlobalKey<ShakingTextFieldState>();
  final GlobalKey<ShakingTextFieldState> _descriptionTfKey = GlobalKey<ShakingTextFieldState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 350.0,
        width: 400.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            color: StacktureColors.popup,
          ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        )
                    ),
                  )
                ],
              ),
              Text(
                "Create a Workspace",
                style: TextStyle(
                    fontSize: 20, color: Colors.white, letterSpacing: 1.5,
                    fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Text(
                    "Workspace Name",
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, letterSpacing: 1.5,
                        fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ShakingTextField(
                  key: _workspaceNameTfKey,
                  label: 'Workspace Name',
                  errorText: 'Must input workspace name',
                  fontSize: 13,
                  errorSize: 11,
                )
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, letterSpacing: 1.5,
                        fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ShakingTextField(
                  key: _descriptionTfKey,
                  label: 'Description',
                  fontSize: 13,
                )
              ),
              SizedBox(height: 20),
              DefaultButton(
                text: "Submit",
                width: 150,
                color: StacktureColors.tertiary,
                function: () {
                  if (_workspaceNameTfKey.currentState!.validateAndShake()) {

                    //add new workspace
                    workspaces.add(
                      Workspace(
                        title: _workspaceNameTfKey.currentState!.getText(), 
                        description: _descriptionTfKey.currentState!.getText(), 
                        creationTime: DateTime.now(),
                        modifiedTime: DateTime.now()
                      )
                    );
                    //trigger refresh list on home page
                    widget.callBack();

                    //pop the dialogue
                    Navigator.pop(context);

                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return WorkspacePage(
                        title: _workspaceNameTfKey.currentState!.getText(),
                      );
                    }));
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}