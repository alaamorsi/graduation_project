import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/lesson_model.dart';
import 'package:graduation_project/modules/student/my_courses/lessons/watch_lesson_screen.dart';
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
    InstructorCubit.get(context).getLessons(courseId);
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = InstructorCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Lessons".tr,
          ),
          body: Padding(
            padding: EdgeInsets.all(screenWidth*.02),
            child: ConditionalBuilder(
              condition: state is GetInstCourseLessonsSuccessState ||cubit.lessons.isNotEmpty,
              builder: (BuildContext context) =>
              cubit.lessons.isNotEmpty?ListView.builder(
                itemBuilder: (BuildContext context, int index)=> buildLessonItem(lesson: cubit.lessons[index], theme: theme, cubit: cubit,index: index),
                itemCount: cubit.lessons.length,):
              Center(child: Text("There isn't lessons yet".tr,
                style: font.copyWith(
                    color: theme.primaryColor,
                    fontSize: screenWidth * 0.06),
              ),),
              fallback: (BuildContext context) =>
                  ConditionalBuilder(
                    condition: state is GetInstCourseLessonsErrorState,
                    builder: (BuildContext context)=> Center(child: Text("Some thing went wrong".tr,
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
                  ),
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

  Widget buildLessonItem({
    required LessonModel lesson,
    required int index,
    required ThemeData theme,
    required InstructorCubit cubit,
  })
  {
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
                    image:  cubit.imageProvider,
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