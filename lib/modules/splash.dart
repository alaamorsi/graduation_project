import 'package:flutter/material.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:lottie/lottie.dart';
import '../shared/component/constant.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6,milliseconds: 600)).then((value){
      if(jwt.isNotEmpty){
        if(role == 'student'){
          navigateAndFinish(context, const StudentLayout());
        }else if(role == 'instructor'){
        }
      }else{
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset("Assets/splash.json"),
        ),
        ]
      ),
    );
  }
}

