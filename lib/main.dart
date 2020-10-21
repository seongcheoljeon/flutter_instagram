import 'package:flutter/material.dart';
import 'package:flutter_practice/constants/material_color.dart';
import 'package:flutter_practice/screens/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Instagram',
      theme: ThemeData(
        primarySwatch: white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignIn(),
    );
  }
}
