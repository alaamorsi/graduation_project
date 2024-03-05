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
  double t1=0;
  double t2=0;
  double t3=0;
  double t4=0;
  double t5=0;
  double t6=0;
  double t7=0;
  double t8=0;
  double t9=0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {imageOp=1;});});
    Future.delayed(const Duration(seconds: 4)).then((value){
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
              colors: [Colors.transparent, Colors.black],),),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: imageOp,
                onEnd: (){
                  setState(() {
                    t1=1;
                  });
                },
                child: Container(
                  height: ((screenHeight/5)),
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("Assets/icon.png"),fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t1,
                      onEnd: (){
                        setState(() {
                          t2=1;
                        });
                      },
                      child: const Text('D',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t2,
                      onEnd: (){
                        setState(() {
                          t3=1;
                        });
                      },
                      child: const Text('I',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t3,
                      onEnd: (){
                        setState(() {
                          t4=1;
                        });
                      },
                      child: const Text('G',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t4,
                      onEnd: (){
                        setState(() {
                          t5=1;
                        });
                      },
                      child: const Text('I',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t5,
                      onEnd: (){
                        setState(() {
                          t6=1;
                        });
                      },
                      child: const Text('T',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t6,
                      onEnd: (){
                        setState(() {
                          t7=1;
                        });
                      },
                      child: const Text('U',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t7,
                      onEnd: (){
                        setState(() {
                          t8=1;
                        });
                      },
                      child: const Text('T',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t8,
                      onEnd: (){
                        setState(() {
                          t9=1;
                        });
                      },
                      child: const Text('O',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: t9,
                      child: const Text('R',
                        style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
class Char {
  late double opacity;
  late String char;
  Char({
    required this.opacity,required this.char
});
}

//Flexible(
//                 child: AnimatedSlide(
//                   duration:const Duration(milliseconds: 700),
//                   offset: Offset(text1Move,0),
//                   curve: Curves.fastOutSlowIn,
//                   child: const Text("very easy ,entertaining and useful application",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.w600),),
//                 ),
//               ),