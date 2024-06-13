import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'Exams.dart';
import 'assignments.dart';
import 'chats_screen.dart';
import 'lessons_screen.dart';

class ClassLeader extends StatefulWidget {
  final MyCourse course;
  const ClassLeader({super.key,required this.course});

  @override
  State<ClassLeader> createState() => _ClassLeaderState();
}

class _ClassLeaderState extends State<ClassLeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      StudentCubit.get(context).isLoading = false;
    });
  }
  @override Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(
        context: context,
        title:widget.course.subject.tr,
      ),
      body: Padding(padding:  EdgeInsets.symmetric(horizontal: screenWidth * .02),
        child: Wrap(
          children: [
            dashboardItem(
              context: context,
              title: "Lessons",
              image: "Assets/for_teacher/recorded.png",
              goTo: () {
                navigateTo(context, LessonsScreen(course: widget.course,));
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
          ],
        ),
      ),
    );
  }
}
