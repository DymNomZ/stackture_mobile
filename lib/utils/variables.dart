import 'dart:ui';

import 'package:stackture_mobile/utils/workspace.dart';

//WILL HOLD TOKEN OF USER
String? token;

List<Workspace> workspaces = [];

List<dynamic> treeNodes = [];

List <Shadow> defaultShadow = 
[
  Shadow(
    offset: Offset(2.0, 2.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 0)
  ),
];