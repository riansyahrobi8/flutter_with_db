import 'package:flutter/material.dart';
import 'package:flutter_with_data/Home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter DB",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red), // set thema aplikasi secara keseluruhan
      home: Home(),
    );
  }
}
