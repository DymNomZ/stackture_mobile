import 'package:flutter/material.dart';

class FABLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width - 100,
      scaffoldGeometry.scaffoldSize.height - 100,
    );
  }
}