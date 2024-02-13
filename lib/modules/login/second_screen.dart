import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/login/student_register.dart';
import 'package:graduation_project/modules/login/teacher_register.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:graduation_project/shared/constant.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}
class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
     appBar: AppBar(
       title:InkWell(
         onTap: (){navigateAndFinish(context, LoginScreen());},
         child: Row(
             children: [
               Icon(Icons.arrow_back_ios_rounded,
                 color: Theme.of(context).primaryColor,size: 35.0,
               ),
               Text("سجل الدخول",
                 style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 25.0,fontWeight: FontWeight.bold),)
             ]
         ),
       ),
     ),
     body:Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'حساب جديد',
                 style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,
                     color: Theme.of(context).primaryColor),
               ),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'سجل الأن لتستمتع بخدماتنا الرائعة',
                 style:TextStyle(fontSize: 13.0, color: Colors.grey),
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
                        navigateAndFinish(context, teacherScreen());
                      },
                      context: context,
                      color: Theme.of(context).canvasColor),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  child: usedButton(
                      text: 'طالب',
                      onPressed: () {
                        navigateAndFinish(context, studenScreen());
                      },
                      context: context,
                      color: Theme.of(context).canvasColor),
                ),
              ],
            ),
         ],
       ),
     ),
    );
  }}