import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    return ConditionalBuilder(
        condition: myCourses.isNotEmpty,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: myCourses.length,
              itemBuilder: (context ,index){
                return paidCourse(
                    context: context,
                    course: myCourses[index],
                    color: theme.cardColor
                );
              }
          ),
        ),
        fallback: (context) => const Center(child: Text('You are not in class yet')),
      );
  }
}
