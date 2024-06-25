import 'dart:convert';
import 'dart:typed_data';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'watch_lesson_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/models/lesson_model.dart';
import '../../../../../shared/component/constant.dart';
class LessonsScreen extends StatelessWidget{
  final CourseModel course;
  const LessonsScreen({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context,state) {},
        builder:(context,state){
        var cubit = StudentCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: "lessons".tr),
          body: Padding(
            padding: EdgeInsets.all(screenWidth*.02),
            child: ConditionalBuilder(
              condition: state is GetCourseLessonsSuccessState ||cubit.lessons.isNotEmpty,
              builder: (BuildContext context) =>
                cubit.lessons.isNotEmpty?
                ListView.builder(
                itemBuilder: (BuildContext context, int index)=> buildLessonItem(lesson: cubit.lessons[index], theme: theme, course: course,index: index, cubit: cubit),
                itemCount: cubit.lessons.length,):
                Center(child: Text("There isn't lessons yet".tr,
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),),
              fallback: (BuildContext context) =>
                  ConditionalBuilder(
                    condition: state is GetCourseLessonsErrorState,
                    builder: (BuildContext context)=> Center(child: Text("Some thing went wrong".tr,
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
                  ),
            ),
          ),
        );
      }
    );
  }

  Widget buildLessonItem({
    required LessonModel lesson,
    required int index,
    required ThemeData theme,
    required CourseModel course,
    required StudentCubit cubit,
  })
  {
    ImageProvider<Object> image=const AssetImage("Assets/profile/man_1.png");
    if(course.instProfilePicture!.isNotEmpty){
      Uint8List picture = base64Decode(course.instProfilePicture as String);
      image = MemoryImage(picture);
    }
    return InkWell(
      onTap: (){
        Get.to(()=>WatchLessonScreen(lesson: lesson, index: index, lessons: cubit.lessons,));
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth*.02),
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Row(
          children: [
            //Teacher image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: screenHeight/10,
                height: screenHeight/10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image:  image,
                    fit: BoxFit.cover,),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text(lesson.lessonName,
                  style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                ),
                const SizedBox(height: 5,),
                Text(lesson.period,
                  style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                ),
                const SizedBox(height: 10,),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Icon( Icons.play_circle,color: theme.primaryColor,size: 33,)
                ),
              ],
            ),
            const SizedBox(width: 15,),
          ],
        ),
      ),
    );
  }
}
