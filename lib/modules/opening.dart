import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  double imageOp=0;
  double text1Move=9;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {imageOp=1;});});
    Future.delayed(const Duration(seconds: 3)).then((value){
      if(jwt!.isNotEmpty){
        if(role == 'student'){
          navigateAndFinish(context, const StudentLayout());
        }else if(role == 'instructor'){
          navigateAndFinish(context, const StudentLayout());
        }
      }else{
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black,],),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: imageOp,
                onEnd: (){
                  setState(() {
                    text1Move=0;
                  });
                },
                child: Container(
                  height: ((screenHeight/4)),
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("Assets/Digitutor1.png"),fit: BoxFit.cover),
                  ),
                ),
              ),
              Flexible(
                child: AnimatedSlide(
                  duration:const Duration(milliseconds: 700),
                  offset: Offset(text1Move,0),
                  curve: Curves.fastOutSlowIn,
                  child: const Text("very easy ,entertaining and useful application",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w600),),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

