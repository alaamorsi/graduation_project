import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/layout/instructor/instructor_layout.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:lottie/lottie.dart';
import '../../layout/student/student_layout.dart';
import 'introduction_screen.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  double logoOpacity=0;
  double t1=-5;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 50), () {
      setState(() {logoOpacity=1;});});
    Future.delayed(const Duration(seconds: 6)).then((value){
      if(jwt!.isNotEmpty){
        if(role == 'student'){
          navigateAndFinish(context, const StudentLayout());
        }else if(role == 'instructor'){
          navigateAndFinish(context, const InstructorLayout());
        }else{
          navigateAndFinish(context, const InstructorLayout());
        }
      }else{
        navigateTo(context, const Introduction());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: logoOpacity,
            onEnd: (){
              setState(() {
                t1 =0;
              });
            },
            child: LottieBuilder.asset("Assets/animated.json")
          ),
          const SizedBox(height: 20,),
          AnimatedSlide(
            duration: const Duration(seconds: 2),
            offset: Offset(t1, 0),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: Theme.of(context).canvasColor,offset:const Offset(-3, 6),spreadRadius: 3,blurRadius: 3),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('D i g i t u t o r',
                      style: font.copyWith(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
                  ]
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
