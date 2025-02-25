import 'package:flutter/material.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:stackture_mobile/recent_activity_panel.dart';
import 'package:stackture_mobile/utils/colors.dart';
import 'package:stackture_mobile/utils/fab_location.dart';
import 'package:stackture_mobile/utils/variables.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StacktureColors.secondary,
      appBar: AppBar(
        backgroundColor: StacktureColors.primary,
        leading: IconButton(
          icon: Icon(Icons.door_back_door_outlined, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
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
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  "Workspaces",
                  style: TextStyle(
                    fontSize: 30, color: Colors.white, letterSpacing: 1.5,
                    fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                    shadows: defaultShadow
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "These are isolated spaces where you can have study sessions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15, color: Colors.white, letterSpacing: 1.5,
                    fontWeight: FontWeight.bold, fontFamily: 'LilitaOne',
                    shadows: defaultShadow
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ReorderableGridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                      crossAxisCount: 1,
                      childAspectRatio: 2.5
                    ),
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      //Note currentNote = filteredNotes[index];
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

                                  },
                                  title: RichText(
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: '${currentNote.title} \n',
                                        style: TextStyle(
                                            color: cardDarkMode(currentNote),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            height: 1.5),
                                        children: [
                                          TextSpan(
                                            text: currentNote.content,
                                            style: TextStyle(
                                                color: cardDarkMode(currentNote),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                                height: 1.5),
                                          )
                                        ]),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentNote.modifiedTime)}\nCreated on: ${DateFormat('EEE MMM d, yyyy h:mm a').format(currentNote.creationTime)}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic,
                                          color: cardDarkMode(currentNote)),
                                    ),
                                  ),
                                                ),
                              ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13.0),
                                  child: Column(
                                    children: [
                                      DeleteNoteButton(onPressed: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (_) => const ConfirmDelete(),
                                      );
                                      if (result != null && result) {
                                        setState(() {
                                          filteredNotes.remove(currentNote);
                                          currentNote.delete();
                                        });
                                      }}, note: currentNote,),
                                      MoveButton(onPressed: (){
                                        setState(() {
                                          isMoving = true;
                                          folderList(currentNote);
                                        });
                                      }),
                                    ],
                                  ),
                                )
                            ],
                          )));
                    },
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        
                      });
                    },
                  )
                )
              ],
            ),
          ),
          RecentActivityPanel(isVisible: _showRecent),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: 10,
            left: _showRecent ? 170 : 10,
            child: FloatingActionButton(
              heroTag: "recent_btn",
              onPressed: toggleRecent,
              backgroundColor: StacktureColors.primary,
              child: Icon(
                _showRecent ? Icons.close : Icons.history,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
