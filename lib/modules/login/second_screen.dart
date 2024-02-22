import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/login/student_register.dart';
import 'package:graduation_project/modules/login/teacher_register.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../shared/component/constant.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}
class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       title:InkWell(
         onTap: (){navigateAndFinish(context, const LoginScreen());},
         child: Row(
             children: [
               Icon(Icons.arrow_back_ios_rounded,
                 color: Theme.of(context).canvasColor,size: 35.0,
               ),
               Text("سجل الدخول",
                 style: font.copyWith(color: Theme.of(context).canvasColor,fontSize: 25.0,fontWeight: FontWeight.bold),)
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
                 style: font.copyWith(fontSize: 25.0,fontWeight: FontWeight.bold,
                     color: Theme.of(context).canvasColor),
               ),
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 'سجل الأن لتستمتع بخدماتنا الرائعة',
                 style: font.copyWith(fontSize: 13.0, color: Colors.grey),
               ),
             ],
           ),
           const SizedBox(height: 20.0),
           Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: usedButton(
                      text: 'مدرس',
                      onPressed: () {
                        navigateAndFinish(context, const TeacherScreen());
                      },
                      context: context,
                      color: Theme.of(context).cardColor),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: usedButton(
                      text: 'طالب',
                      onPressed: () {
                        navigateAndFinish(context, const StudentScreen());
                      },
                      context: context,
                      color: Theme.of(context).cardColor),
                ),
              ],
            ),
         ],
       ),
     ),
    );
  }}