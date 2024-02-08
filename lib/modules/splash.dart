import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/secnd_screen.dart';
import 'package:graduation_project/modules/login/login_screen.dart';

class splash extends StatefulWidget {


  @override
  State<splash> createState() =>_suiupState();
}

class _suiupState extends State<splash> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 5)  ,(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen(),
      )
      );
    }
    );
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("Assets/11.png"),
              radius: 100,


            ),
            SizedBox(height: 15,),
            Text("Notes",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),),
          ],
        ),
      ),
    );
  }
}
