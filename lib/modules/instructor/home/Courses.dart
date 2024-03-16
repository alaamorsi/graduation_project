import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class ChooseCoursesScreen extends StatelessWidget {
  const ChooseCoursesScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: secondAppbar(context: context, title: "What is the Course Type?"),
      body:Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
             InkWell(
                onTap: () {
                  //navigateAndFinish(context, const TeacherScreen());
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(39),
                      height: screenWidth/1.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Image(image: AssetImage("Assets/for_teacher/live.png")),
                    ),
                    const SizedBox(height: 10.0),
                    Text("Live",style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                  ],
                ),
              ),
              newDivider(),
              InkWell(
                onTap: () {
                  //navigateAndFinish(context, const StudentScreen());
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(39),
                      height: screenWidth/1.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Image(image: AssetImage("Assets/for_teacher/recorded.png")),
                    ),
                    const SizedBox(height: 10.0),
                    Text("Recorded",style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}