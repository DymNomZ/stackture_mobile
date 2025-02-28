import 'dart:ui';

import 'package:stackture_mobile/utils/workspace.dart';

List<Workspace> workspaces = [];

  //Dummy filler task
  Workspace dummy = Workspace(
    title: 'Sample Task', description: 'Sir Gemota\'s SOCSCI 031 and his adventures around the world',
    creationTime: DateTime.now(), modifiedTime: DateTime.now()
  );

List <Shadow> defaultShadow = 
[
  Shadow(
    offset: Offset(2.0, 2.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 0)
  ),
];