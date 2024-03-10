import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/component/components.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit,CourseStates>(
        listener: (context,state) {},
        builder:(context,state){
          return Scaffold(
            appBar: secondAppbar(context: context, title: "Chat"),
            body: ConditionalBuilder(
            condition: true,
            builder: (context) => ListView.builder(
              itemBuilder: (BuildContext context, int index)=>Center(child: Text('Chat of Lesson $index')),
              itemCount: 2,
            ),
            fallback: (context) => const Center(child: Text('You are not in class yet')),
            ),
          );
        }
    );
  }
}