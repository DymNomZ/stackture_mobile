import 'package:flutter/material.dart';
import 'package:stackture_mobile/utils/api_service.dart';
import 'package:stackture_mobile/utils/branch_painter.dart';
import 'package:stackture_mobile/utils/tree_view.dart';
import 'package:stackture_mobile/utils/workspace.dart';

class TreeScreen extends StatefulWidget {

  Workspace workspace;

  TreeScreen({super.key, required this.workspace});
  
  @override
  _TreeScreenState createState() => _TreeScreenState();
}

class _TreeScreenState extends State<TreeScreen> {
  
  final List<Map<String, dynamic>> problems = 
  [
];

  Map<int, Map<String, dynamic>> _problemMap = {};
  Map<int, Offset> _nodePositions = {}; // Store node positions

  @override
  void initState() {
    super.initState();
    ApiService().getTree(widget.workspace.id);
    _problemMap = Map.fromIterable(problems, key: (item) => item['id'], value: (item) => item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint( // Use CustomPaint to draw lines
              painter: BranchPainter(_nodePositions, _problemMap),
              child: TreeView(
                problems: problems,
                problemMap: _problemMap,
                onNodePosition: (id, offset) {
                  setState(() {
                    _nodePositions[id] = offset;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}