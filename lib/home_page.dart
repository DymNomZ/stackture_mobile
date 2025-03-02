import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:stackture_mobile/recent_activity_panel.dart';
import 'package:stackture_mobile/utils/api_service.dart';
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

  //Will be used to load workspaces of user
  void loadUserWorkspaces() async {

    Future<List<dynamic>> userWorkspaces = ApiService().fetchWorkspaces();
    List<dynamic> workspacesList = await userWorkspaces;

    for(var workspace in workspacesList){
      workspaces.add(
        Workspace(
          id: workspace["id"], 
          rootId: workspace["root_id"] ?? 0, 
          title: workspace["title"],
          description: workspace["description"]
        )
      );
    }

    refreshWorkspaces();
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
          onPressed: () => _showLogoutConfirmation(context),
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

              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Workspaces",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LilitaOne',
                    shadows: defaultShadow,
                  ),
                ),
              ),

              if (workspaces.isEmpty) ...[
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    "These are isolated spaces where you can have study sessions. Click the '+' to start learning!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'LilitaOne',
                      shadows: defaultShadow,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],

              Expanded(
                child: ReorderableGridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 3,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => WorkspacePage(
                                      workspace: currentWorkspace,
                                    ),
                                  ));
                                },
                                title: RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: '${currentWorkspace.title} \n',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: currentWorkspace.description,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13.0),
                              child: IconButton(
                                icon: Icon(Icons.delete_outline, color: Colors.white, size: 30),
                                onPressed: () {
                                  workspaces.removeAt(index);
                                  refreshWorkspaces();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      // Ignore
                    });
                  },
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: StacktureColors.primary, // Set background color
          title: Text(
            "Confirm Logout",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              fontFamily: 'LilitaOne',
              shadows: defaultShadow,
            ), // Change text color
          ),
          content: Text(
            "Are you sure you want to log out?",
            style: TextStyle(color: Colors.white70), // Slightly dim text color
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
              child: Text("Logout", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
        );
      },
    );
  }

}
