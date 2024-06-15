import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/lesson_model.dart';
import 'package:graduation_project/modules/tutor/home/courses/lessons/add_lesson.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../../shared/component/constant.dart';
import 'package:get/get.dart';

class Lessons extends StatelessWidget {
  final int courseId;
  const Lessons({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    InstructorCubit.get(context).getLessons();
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = InstructorCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Lessons",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth *.02),
            child: ConditionalBuilder(
              condition: cubit.lessons.isNotEmpty,
              builder: (context) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index)=>lessonItem(lesson: cubit.lessons[index], color: theme.primaryColor),
                  itemCount: 3,
                );
              },
              fallback: (context){
                if(state is GetInstCourseLessonsErrorState){
                  return Center(
                    child: Text(
                      'You did not add any lessons yet',
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),
                  );
                }
                else{
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Get.to(() => AddLessons(courseId: courseId,));
                  },
                  backgroundColor: theme.primaryColor,
                  tooltip: 'addLesson'.tr,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget lessonItem({
    required LessonModel lesson,
    required Color color,
  }){
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.02),
      margin: EdgeInsets.all(screenWidth * 0.02),
      width: screenWidth,
      height: screenHeight * 0.14,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(23.0),
        ),
      ),
      child: Row(
        children: [
          //Teacher image
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.name,
                style: font.copyWith(fontSize: 16.0, color: color),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                lesson.period,
                style: font.copyWith(
                    fontSize: 12.0, color: Colors.black.withOpacity(.5)),
              )
            ],
          ),
        ],
      ),
    );
  }
}