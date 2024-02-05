import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context as BuildContext).size.width;
    double screenHeight = MediaQuery.of(context as BuildContext).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

      ),
      home:splash(),
    );
  }
}
