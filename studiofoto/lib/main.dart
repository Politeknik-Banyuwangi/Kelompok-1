import 'package:flutter/material.dart';
import 'package:studiofoto/screens/homepage.dart';

void main() {
  runApp (MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Studio Foto",
      home: Homepage(),   
    );
  }
}