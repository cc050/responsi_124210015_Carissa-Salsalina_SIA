import 'package:flutter/material.dart';
import 'package:responsi/HomePage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.brown
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );

  }
}




