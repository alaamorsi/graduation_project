import 'package:flutter/material.dart';

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
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: screenWidth,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: screenWidth / 2.5,
                  child: Text(
                    'E',
                    style: TextStyle(
                        fontSize: screenHeight / 3, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
