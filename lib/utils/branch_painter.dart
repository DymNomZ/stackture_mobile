import 'package:flutter/material.dart';

class BranchPainter extends CustomPainter {
  final Map<int, Offset> nodePositions;
  final Map<int, Map<String, dynamic>> problemMap;
  final screenHeight;
  final screenWidth;

  BranchPainter(this.nodePositions, this.problemMap, this.screenHeight, this.screenWidth);

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

          // print(screenHeight / 2);
          // print(screenWidth / 2);

          // Adjust offsets to draw lines from the center of the nodes
          double nodeSize = 56.0; // Adjust based on node's size (padding + icon size)
          double adjustWidth = nodeSize * 2;
          double adjustHeight = nodeSize;

          double centerWidth = -(screenWidth / 2) + adjustWidth;
          double centerHeight = -(screenHeight / 2) + adjustHeight;

          Offset parentCenter = parentPos + Offset(nodeSize / 2, nodeSize / 2) 
          + Offset(centerWidth, centerHeight); //control height of lines
          Offset childCenter = childPos + Offset(nodeSize / 2, nodeSize / 2) 
          + Offset(centerWidth, centerHeight);

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