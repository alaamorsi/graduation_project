import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'Exams.dart';
import 'assignments.dart';
import 'chats_screen.dart';
import 'lessons_screen.dart';

class ClassLeader extends StatelessWidget {
  final MyCourse course;
  const ClassLeader({super.key,required this.course});

  @override Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(
        context: context,
        title:course.subject.tr,
      ),
      body: Padding(padding:  EdgeInsets.symmetric(horizontal: screenWidth * .02),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            dashboardItem(
              context: context,
              title: "Lessons",
              image: "Assets/for_teacher/recorded.png",
              goTo: () {
                navigateTo(context, LessonsScreen(course: course,));
              },
            ),
            dashboardItem(
              context: context,
              title: "Chat",
              image: "Assets/for_teacher/chat.png",
              goTo: () {
                Get.to(()=>const ChatsScreen());
              },
            ),
            dashboardItem(
              context: context,
              title: "Exams",
              image: "Assets/for_teacher/exam.png",
              goTo: () {
                Get.to(()=>const ExamsScreen());
              },
            ),
            dashboardItem(
              context: context,
              title: "Assignments",
              image: "Assets/for_teacher/exam.png",
              goTo: () {
                Get.to(()=>const AssignmentScreen());
              },
            ),
            dashboardItem(
              context: context,
              title: "Attachments",
              image: "Assets/for_teacher/attach.png",
              goTo: () {},
            ),
          ],
        ),
      ),
    );
  }
}
