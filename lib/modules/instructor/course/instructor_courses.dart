import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class TeacherCoursesScreen extends StatelessWidget {
  const TeacherCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        hasLeading: true,
        leadingIcon: const Padding(
          padding: EdgeInsets.only(
            left: 15,top: 5,bottom: 5,
          ),
          child: Image(image: AssetImage("Assets/appbar.png")),
        ),
        title: Text("Course",
          style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: theme.primaryColorDark),
        ),
      ),
      body: ConditionalBuilder(
          condition: false,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context ,index){
                  return const Text("Working on it");
                }
            ),
          ),
          fallback: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text("You Didn't make any Class yet",
                  style: font.copyWith(fontSize: 22.0,color: Theme.of(context).primaryColorDark),
                  textAlign:TextAlign.center,
                ),
              ),
          ),
        ),
    );
  }
}
