import 'dart:ui';

import 'package:stackture_mobile/utils/workspace.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

//WILL HOLD TOKEN OF USER
String? token;

List<Workspace> workspaces = [];

WebSocketChannel? channel;

List <Shadow> defaultShadow = 
[
  Shadow(
    offset: Offset(2.0, 2.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 0)
  ),
];