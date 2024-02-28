import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color cardColor= Theme.of(context).cardColor;
    return ConditionalBuilder(
      condition: courses.isNotEmpty,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context , index)=> buildDiscoveryItem(
            context: context,
            courseTeacherImage: courses[index].teacherImage,
            courseTeacherName: courses[index].teacherName,
            courseSubject: courses[index].subject,
            courseEduLevel: courses[index].eduLevel,
            courseTerm: courses[index].term,
            courseYear: courses[index].year,
            courseVideosNumber: courses[index].videosNumber,
            isReserved: true,
            cardColor: cardColor,
          ),
          separatorBuilder: (context , index)=>const SizedBox(width: 10.0,),
          itemCount: 1,
        ),
      ),
      fallback: (context) => const Center(child: Text('You are not in class yet')),
    );
  }
}
