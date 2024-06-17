import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/my_courses/screens/add_rate.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'Exams.dart';
import 'assignments.dart';
import 'chats_screen.dart';

class ClassLeader extends StatefulWidget {
  final CourseModel course;
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
                // navigateTo(context, LessonsScreen(course: widget.course,));
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              onPressed: () {
                Get.to(()=>RateScreen(courseId: widget.course.courseId));
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
  }
}
