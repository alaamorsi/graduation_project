import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/modules/tutor/home/courses/publish_course.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'add_videos.dart';
import 'chat.dart';

class TutorCoursesScreen extends StatelessWidget {
  final String subject;
  const TutorCoursesScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit,InstructorStates>(
      listener: (context , state ){
        InstructorCubit.get(context).publishCourse();
        if(state is PublishCourseLoadingState)
          Get.off(()=>PublishCourse());

      },
      builder: (context , state){
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title:subject.tr,
          ),
          body: Padding(padding: const EdgeInsets.all(20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
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
        );
      },
    );
  }
}