import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/my_courses/live_screen.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'add_description.dart';
import 'lessons/lessons.dart';
import 'show-students.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'assignments/assignments.dart';
import 'attachments/attachments.dart';
import 'chat.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorCoursesScreen extends StatelessWidget {
  final InstructorCourseModel course;

  const TutorCoursesScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(
            hasAction: !course.isPublished,
            actionIcon: Row(
              children: [
                Text(
                  'Publish'.tr,
                  style: font.copyWith(color: theme.primaryColor),
                ),
                IconButton(
                    onPressed: () {
                      InstructorCubit.get(context)
                          .publishCourse(course.courseId);
                    },
                    icon: const Icon(Icons.check_box)),
              ],
            ),
            context: context,
            title: course.courseName.tr,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Wrap(
                children: [
                  if (course.type == 'Recorded')
                    dashboardItem(
                      context: context,
                      title: "Lessons".tr,
                      image: "Assets/for_teacher/play.png",
                      goTo: () {
                        cubit.getLessons(course.courseId);
                        Get.to(() => Lessons(
                              courseId: course.courseId,
                            ));
                      },
                    ),
                  if(course.type=='Live')
                    dashboardItem(
                      context: context,
                      title: "Live".tr,
                      image: "Assets/for_teacher/play.png",
                      goTo: () {
                        cubit.getLessons(course.courseId);
                        // Get.to(() =>launchUrl(Uri.parse('https://digitutors.runasp.net/MakeRoom.html?courseid=${course.courseId}&id=${CacheHelper.getData(key: 'id')}&username=${CacheHelper.getData(key: 'userName')}')));
                      },
                    ),
                  dashboardItem(
                    context: context,
                    title: "Students".tr,
                    image: "Assets/for_teacher/students.png",
                    goTo: () {
                      cubit.getStudents(course.courseId);
                      Get.to(() => ShowStudents(
                            courseId: course.courseId,
                          ));
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Assignments".tr,
                    image: "Assets/for_teacher/exam.png",
                    goTo: () {
                      cubit.getAssignments(course.courseId);
                      Get.to(() => AssignmentsScreen(
                            course: course,
                          ));
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Attachments".tr,
                    image: "Assets/for_teacher/attach.png",
                    goTo: () {
                      cubit.getAttachments(course.courseId);
                      Get.to(() => AttachmentsScreen(
                            course: course,
                          ));
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Chat".tr,
                    image: "Assets/for_teacher/chat.png",
                    goTo: () async {
                      await cubit.getChat(course.courseId, 1);
                      Get.to(() => ChatScreen(
                            courseId: course.courseId,
                          ));
                    },
                  ),
                ],
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
                    Get.to(() => AddDescription(
                          course: course,
                        ));
                  },
                  backgroundColor: theme.primaryColor,
                  tooltip: 'Edit'.tr,
                  child: const Icon(
                    Icons.edit_note,
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
        padding: EdgeInsets.all(screenWidth * 0.03),
        height: screenHeight * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Publish'.tr,
              style:
                  font.copyWith(color: theme.primaryColorDark, fontSize: 16.0),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Text(
              "Your course is not published ,Publish Now ?".tr,
              textAlign: TextAlign.center,
              style:
                  font.copyWith(color: theme.primaryColorDark, fontSize: 16.0),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
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
                    child: Text(
                      'Not now'.tr,
                      style: font.copyWith(
                          color: theme.primaryColor, fontSize: 15.0),
                    )),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(theme.primaryColor)),
                      onPressed: submit,
                      child: Text(
                        'Publish'.tr,
                        style:
                            font.copyWith(color: Colors.white, fontSize: 16.0),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
