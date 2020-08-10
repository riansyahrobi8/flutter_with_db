import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter with DB"),
        leading: Icon(Icons.menu),
      ),
      body: Center(
        child: Text("Center"),
      ),
    );
  }
}
