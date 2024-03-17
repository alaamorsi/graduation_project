import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class TutorCoursesScreen extends StatelessWidget {
  const TutorCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title:"Class",
        hasActions: false,
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
                  style: font.copyWith(fontSize: 22.0,color: theme.primaryColorDark),
                  textAlign:TextAlign.center,
                ),
              ),
          ),
        ),
    );
  }
}
