import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:stackture_mobile/recent_activity_panel.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';
import 'package:stackture_mobile/utils/task.dart';
import 'package:stackture_mobile/utils/variables.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _showRecent = false; // Controls recent activity visibility
  List<Task> taskList = [];

  //Dummy filler task
  Task dummy = Task(
    title: 'Sample Task', description: 'Sir Gemota\'s SOCSCI 031 and his adventures around the world',
    content: 'Lorem ipsum...', creationTime: DateTime.now(), modifiedTime: DateTime.now()
  );

  void toggleRecent() {
    setState(() {
      _showRecent = !_showRecent;
    });
  }

  //Will be used to load tasks of user
  void loadUserTasks(){
    //temporary fill up 10 times
    for(int i = 0; i < 10; i++) {
      taskList.add(dummy);
    }
  }

  @override
  void initState(){
    super.initState();
    loadUserTasks();
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
          print('TO BE IMPLEMENTED');
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
              SizedBox(height: 10),
              Expanded(
                child: ReorderableGridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                    crossAxisCount: 1,
                    childAspectRatio: 2.5
                  ),
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    Task currentTask = taskList[index];
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
                                  print('OPENS TASK TREE');
                                },
                                title: RichText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text: '${currentTask.title} \n',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          height: 1.5),
                                      children: [
                                        TextSpan(
                                          text: currentTask.description,
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
                                    'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentTask.modifiedTime)}\nCreated on: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentTask.creationTime)}',
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
                                print('REMOVE TASK');
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
