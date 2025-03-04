import 'package:flutter/material.dart';

class TreeView extends StatelessWidget {
  final List<Map<String, dynamic>> problems;
  final Map<int, Map<String, dynamic>> problemMap;
  final Function(int, Offset) onNodePosition;

  TreeView({required this.problems, required this.problemMap, required this.onNodePosition});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildTree(problemMap[1]!, constraints.maxWidth, onNodePosition);
      },
    );
  }

  Widget _buildTree(Map<String, dynamic> problem, double maxWidth, Function(int, Offset) onNodePosition) {
    List<Widget> children = [];
    GlobalKey nodeKey = GlobalKey(); // Key to get node position

    // Node
    children.add(
      GestureDetector(
        onTap: () {
          print('Node ${problem['id']} tapped');
        },
        child: Container(
          key: nodeKey, // Assign key to the node
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Text(
            problem['icon'],
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );

    // Branches
    if (problem['branches'].isNotEmpty) {
      List<Widget> branchWidgets = [];
      for (int branchId in problem['branches']) {
        branchWidgets.add(_buildTree(problemMap[branchId]!, maxWidth / problem['branches'].length, onNodePosition));
      }

      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: branchWidgets,
          ),
        ),
      );
    }

    // Get node position after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = nodeKey.currentContext?.findRenderObject() as RenderBox;
      Offset position = renderBox.localToGlobal(Offset.zero);
      onNodePosition(problem['id'], position);
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}