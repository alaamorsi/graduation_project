import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() =>_suiupState();
}

class _suiupState extends State<splash> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds:3), (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);
        });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("Assets/logo.png"),
              radius: 99.0,
            ),
          ]
        ),
      ),
    );
  }
}
