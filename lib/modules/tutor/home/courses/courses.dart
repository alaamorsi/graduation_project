import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'add_videos.dart';
import 'chat.dart';

class TutorCoursesScreen extends StatelessWidget {
  final InstructorCourseModel course;
  const TutorCoursesScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: secondAppbar(
            hasAction: !course.isPublished,
            actionIcon: Row(
              children: [
                Text('Publish'.tr,style: font.copyWith(color: Theme.of(context).primaryColor),),
                IconButton(onPressed: (){
                  InstructorCubit.get(context).publishCourse(course.courseId);
                }, icon: Icon(Icons.check_box)),
              ],
            ),
            context: context,
            title: course.courseName.tr,
          ),
          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.all(screenWidth * 0.02),
              child: Wrap(
                children: [
                  dashboardItem(
                    context: context,
                    title: "Add Video",
                    image: "Assets/for_teacher/addVideo.png",
                    goTo: () {
                      navigateTo(context, const AddVideos());
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Students",
                    image: "Assets/for_teacher/students.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Exams",
                    image: "Assets/for_teacher/exam.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Assignments",
                    image: "Assets/for_teacher/exam.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Attachment",
                    image: "Assets/for_teacher/attach.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Chat",
                    image: "Assets/for_teacher/chat.png",
                    goTo: () {
                      navigateTo(context, const ChatScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DialogScreen extends StatefulWidget {
  final int courseId;
  const DialogScreen({super.key, required this.courseId});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {

  void cansel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context);
    InstructorCubit.get(context).publishCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Dialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(screenWidth*0.03),
        height: screenHeight*0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Publish'.tr,
              style: font.copyWith(color: theme.primaryColorDark, fontSize: 16.0),),
            SizedBox(height: screenHeight*0.02,),
            Text("Your course is not published ,Publish Now ?".tr,
              style: font.copyWith(color: theme.primaryColorDark, fontSize: 16.0),),
            SizedBox(height: screenHeight*0.02,),
            Row(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          theme.scaffoldBackgroundColor),
                      side: MaterialStatePropertyAll(
                          BorderSide(color: theme.primaryColor)),
                    ),
                    onPressed: cansel,
                    child: Text('Not now'.tr, style: font.copyWith(
                        color: theme.primaryColor, fontSize: 15.0),)
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              theme.primaryColor)
                      ),
                      onPressed: submit,
                      child: Text('Publish'.tr,
                        style: font.copyWith(color: Colors.white, fontSize: 16.0),)
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}