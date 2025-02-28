import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:stackture_mobile/recent_activity_panel.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';
import 'package:stackture_mobile/utils/create_workspace_popup.dart';
import 'package:stackture_mobile/utils/workspace.dart';
import 'package:stackture_mobile/utils/variables.dart';
import 'package:stackture_mobile/workspace_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _showRecent = false; // Controls recent activity visibility

  void toggleRecent() {
    setState(() {
      _showRecent = !_showRecent;
    });
  }

  //Will be used to load workspaces of user
  void loadUserWorkspaces(){
    setState(() {
      
    });
  }

  void refreshWorkspaces(){
    setState(() {}); //refresh the list builder
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      loadUserWorkspaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.secondary,
      appBar: AppBar(
        backgroundColor: StacktureColors.primary,
        leading: IconButton(
          icon: Icon(Icons.door_back_door_outlined, color: Colors.white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FABLocation(),
      floatingActionButton: 
      FloatingActionButton(
        heroTag: "add_btn",
        backgroundColor: StacktureColors.primary,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context, 
            builder: (context) {
              return CreateWorkspacePopup(callBack: refreshWorkspaces);
            }
          );
        }
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Workspaces",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, letterSpacing: 1.5,
                      fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                      shadows: defaultShadow
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "These are isolated spaces where you can have study sessions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, letterSpacing: 1.5,
                      fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                      shadows: defaultShadow
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ReorderableGridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                    crossAxisCount: 1,
                    childAspectRatio: 2.5
                  ),
                  itemCount: workspaces.length,
                  itemBuilder: (context, index) {
                    Workspace currentWorkspace = workspaces[index];
                    return Card(
                      key: ValueKey(index),
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      color: StacktureColors.tertiary,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return WorkspacePage(
                                      title: currentWorkspace.title,
                                    );
                                  }));
                                },
                                title: RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text: '${currentWorkspace.title} \n',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          height: 1.5),
                                      children: [
                                        TextSpan(
                                          text: currentWorkspace.description,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                              height: 1.5),
                                        )
                                      ]),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentWorkspace.modifiedTime)}\nCreated on: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentWorkspace.creationTime)}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                          Padding(
                            padding: const EdgeInsets.only(top: 13.0),
                            child: IconButton(
                              icon: Icon(Icons.delete_outline, color: Colors.white, size: 30),
                              onPressed: () {
                                workspaces.removeAt(index);
                                refreshWorkspaces();
                              },
                            ),
                          )
                      ],
                    )));
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      //ignore
                    });
                  },
                )
              )
            ],
          ),
          RecentActivityPanel(isVisible: _showRecent),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 20,
            left: _showRecent ? 170 : -17,
            child: FloatingActionButton(
              heroTag: "recent_btn",
              onPressed: toggleRecent,
              backgroundColor: StacktureColors.primary,
              child: Transform.translate(
                offset: Offset(_showRecent ? 0 : 6, 0), // Moves the icon 5 pixels to the left
                child: Icon(
                  _showRecent ? Icons.close : Icons.history,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
