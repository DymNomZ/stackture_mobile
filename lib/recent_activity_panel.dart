import 'package:flutter/material.dart';

class RecentActivityPanel extends StatelessWidget {
  final bool isVisible;

  RecentActivityPanel({required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isVisible ? 200 : 0,
      height: double.infinity,
      color: Colors.black.withOpacity(0.8),
      padding: EdgeInsets.all(20),
      child: isVisible
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //recent activit area. To be changed to accommodate actual lists
        children: [
          Text("Recent Activity", style: TextStyle(color: Colors.white, fontSize: 20)),
          Divider(color: Colors.white),
          ListTile(
            leading: Icon(Icons.book, color: Colors.white),
            title: Text("Recent Topic 1", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article, color: Colors.white),
            title: Text("Recent Topic 2", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.history, color: Colors.white),
            title: Text("More History", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      )
          : null,
    );
  }
}