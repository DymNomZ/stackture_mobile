import 'package:flutter/material.dart';

class BranchPainter extends CustomPainter {
  final Map<int, Offset> nodePositions;
  final Map<int, Map<String, dynamic>> problemMap;

  BranchPainter(this.nodePositions, this.problemMap);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 4;

    for (var problem in problemMap.values) {
      if (problem['branches'].isNotEmpty) {
        Offset parentPos = nodePositions[problem['id']] ?? Offset.zero;
        for (int branchId in problem['branches']) {
          Offset childPos = nodePositions[branchId] ?? Offset.zero;

          // Adjust offsets to draw lines from the center of the nodes
          double nodeSize = 56.0; // Adjust based on node's size (padding + icon size)
          Offset parentCenter = parentPos + Offset(nodeSize / 2, nodeSize / 2) + Offset(0, -210); //control height of lines
          Offset childCenter = childPos + Offset(nodeSize / 2, nodeSize / 2) + Offset(0, -210);

          canvas.drawLine(parentCenter, childCenter, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever node positions change
  }
}