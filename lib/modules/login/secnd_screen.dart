import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/student.login.dart';
import 'package:graduation_project/modules/login/teatsher_login.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:graduation_project/shared/constant.dart';

class secend_screen extends StatefulWidget {
  const secend_screen({Key? key}) : super(key: key);

  @override
  _secend_screenState createState() => _secend_screenState();
}

class _secend_screenState extends State<secend_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
     body:Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           SizedBox(height: 10.0),
           Container(
             width: double.infinity,
             height: 100.0,
             child: Image(image: mode?AssetImage('Assets/logo1.png'):AssetImage('Assets/logo2.png'),),
           ),
           SizedBox(height: 10.0),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
                 child: Text(
                   'انشاء حساب',
                   style: Theme.of(context).textTheme.titleMedium,
                 ),
               ),
             ],
           ),
           SizedBox(height: 20.0),
           Column(
              children: [

                Container(
                  width: double.infinity,
                  child: usedButton(
                      text: 'مدرس',
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>teacherScreen(),));
                      },
                      context: context,
                      color: Colors.red.shade900),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  child: usedButton(
                      text: 'طالب',
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>studenScreen(),));
                      },
                      context: context,
                      color: Colors.red.shade900),
                ),
              ],
            ),
         ],
       ),
     ),
    );
  }}