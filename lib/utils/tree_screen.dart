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
  
  late List<dynamic> treeNodes = [];

  Map<int, Map<String, dynamic>> nodeMap = {};
  Map<int, Offset> nodePositions = {}; // Store node positions

  int rootId = 0;

  Future<void> loadTreeNodes() async {
    try {
      treeNodes = await ApiService().getTree(widget.workspace.id);

      setState(() {
        nodeMap = {
          for (var item in treeNodes) item['id']: item
        };
      });

      findRootNode();
      
    } catch (e) {
      print('Error loading tree nodes: $e');
    }
  }

  void findRootNode() {
    for (var item in treeNodes) {
      Map<String, dynamic> mapItem = item;
      List<dynamic>? parents = mapItem['parents'];

      if (parents == null || parents.isEmpty) {
        rootId = mapItem['id'];
        break; // Stop after finding the first root
      }
    }
    print("Root ID: $rootId"); // Optional: Print the root ID
  }

  @override
  void initState() {
    super.initState();
    loadTreeNodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint( // Use CustomPaint to draw lines
              painter: BranchPainter(nodePositions, nodeMap),
              child: TreeView(
                rootId: rootId,
                problems: treeNodes,
                problemMap: nodeMap,
                onNodePosition: (id, offset) {
                  setState(() {
                    nodePositions[id] = offset;
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