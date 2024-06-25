import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/my_courses/add_rate.dart';
import 'package:graduation_project/modules/student/my_courses/live_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'assignments/assignments.dart';
import 'attachments/attachments.dart';
import 'lessons/lessons_screen.dart';
import 'chats_screen.dart';

class ClassLeader extends StatelessWidget {
  final CourseModel course;
  const ClassLeader({super.key,required this.course});

  @override

  @override Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state){},
      builder: (context, state){
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(
            context: context,
            title:course.subject.tr,
          ),
          body: Padding(padding:  EdgeInsets.symmetric(horizontal: screenWidth * .02),
            child: Wrap(
              children: [
                if(course.type=='Recorded')
                dashboardItem(
                  context: context,
                  title: "Lessons".tr,
                  image: "Assets/for_teacher/recorded.png",
                  goTo: () async{
                    await cubit.getLessons(course.courseId);
                    Get.to(()=>LessonsScreen(course: course,));
                  },
                ),
                if(course.type=='Live')
                  dashboardItem(
                    context: context,
                    title: "Live".tr,
                    image: "Assets/for_teacher/recorded.png",
                    goTo: () {
                      Get.to(()=>LiveScreen(course: course));
                    },
                  ),
                dashboardItem(
                  context: context,
                  title: "Chat".tr,
                  image: "Assets/for_teacher/chat.png",
                  goTo: () async{
                    await cubit.getChat(course.courseId, 1);
                    Get.to(()=>ChatsScreen(courseId: course.courseId,));
                  },
                ),
                dashboardItem(
                  context: context,
                  title: "Assignments".tr,
                  image: "Assets/for_teacher/exam.png",
                  goTo: () {
                    cubit.getAssignments(course.courseId);
                    Get.to(()=> AssignmentsScreen(course: course,));
                  },
                ),
                dashboardItem(
                  context: context,
                  title: "Attachments".tr,
                  image: "Assets/for_teacher/attach.png",
                  goTo: () {
                    cubit.getAttachments(course.courseId);
                    Get.to(()=>AttachmentsScreen(course: course,));
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                  onPressed: () {
                    Get.to(()=>RateScreen(courseId: course.courseId));
                  },
                  backgroundColor: theme.primaryColor,
                  tooltip: 'addRate'.tr,
                  child: const Icon(
                    Icons.star_rate_rounded,
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
}
