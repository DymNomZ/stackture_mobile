import 'dart:ui';

import 'package:stackture_mobile/utils/workspace.dart';

//WILL HOLD TOKEN OF USER
String? token;

//temp
Workspace w = Workspace(
  id: 1, 
  title: "title", description: "description", 
  modifiedTime: DateTime.now(), creationTime: DateTime.now()
);

List<Workspace> workspaces = [w];

List <Shadow> defaultShadow = 
[
  Shadow(
    offset: Offset(2.0, 2.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 0)
  ),
];