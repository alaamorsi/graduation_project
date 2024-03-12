import 'package:flutter/material.dart';
import 'package:graduation_project/modules/registeration/register/student_register.dart';
import 'package:graduation_project/modules/registeration/register/teacher_register.dart';
import 'package:graduation_project/shared/component/components.dart';

import '../../../shared/component/constant.dart';
import '../login/login_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();
}
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child:Form(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      navigateAndFinish(context, const LoginScreen());
                    },
                    child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded,
                            color: Theme.of(context).primaryColor,size: 36.0,
                          ),
                          Text("login",
                            style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 27.0,fontWeight: FontWeight.bold),)
                        ]
                    ),
                  ),
                  SizedBox(height: screenHeight/4,),
                  Column(
                    children: [
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text(
                       'new account',
                       style: font.copyWith(fontSize: 25.0,fontWeight: FontWeight.bold,
                           color: Theme.of(context).primaryColor),
                     ),
                    ],
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text(
                       'Register now to enjoy our great services',
                       style: font.copyWith(fontSize: 13.0, color: Colors.grey),
                     ),
                    ],
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                    width: double.infinity,
                    child: usedButton(
                       text: 'teacher',
                       onPressed: () {
                         navigateAndFinish(context, const TeacherScreen());
                       },
                       context: context,
                       color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                    width: double.infinity,
                    child: usedButton(
                       text: 'student',
                       onPressed: () {
                         navigateAndFinish(context, const StudentScreen());
                       },
                       context: context,
                       color: Theme.of(context).primaryColor),
                    ),
                    ],
                   ),
                ],
              ),
           ),
          ),
        ),
    );
  }
}