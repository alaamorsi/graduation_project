import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/registration/register/student_register.dart';
import 'package:graduation_project/modules/registration/register/teacher_register.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

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
      body:Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded,
                          color: Theme.of(context).primaryColor,size: 30.0,
                        ),
                      ),
                    ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Which one are you".tr, style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20.0,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {navigateAndFinish(context, const TeacherScreen());},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(39),
                          height: screenWidth/1.5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Image(image: AssetImage("Assets/tutor.png")),
                        ),
                        const SizedBox(height: 10.0),
                        Text("Tutor".tr,style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                      ],
                     ),
                  ),
                  newDivider(),
                  InkWell(
                    onTap: () {navigateAndFinish(context, const StudentScreen());},
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(39),
                          height: screenWidth/1.5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Image(image: AssetImage("Assets/student.png")),
                        ),
                        const SizedBox(height: 10.0),
                        Text("Student".tr,style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}