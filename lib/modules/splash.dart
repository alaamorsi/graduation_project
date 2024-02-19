import 'package:flutter/material.dart';
import 'package:graduation_project/modules/introduction_screen.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() =>SplashState();
}
class SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds:3), (){
          navigateAndFinish(context, const Introduction());
          // if(uId.isNotEmpty)
          // {
          //   if(uId=='Student')
          //   {
          //     navigateAndFinish(context, const StudentLayout());
          //   }
          //   else if(uId=='Teacher')
          //   {
          //
          //   }
          // }
          // else
          // {
          //   navigateAndFinish(context, const LoginScreen());
          // }
        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:   Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage("Assets/logo.png"),
              radius: 111.0,
              backgroundColor: HexColor("#000080"),
            ),
          ]
        ),
      ),
    );
  }
}
