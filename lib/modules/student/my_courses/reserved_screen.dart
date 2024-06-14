import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import 'screens/course_leader.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> progress = [0, 10, 50];
    var theme = Theme.of(context);
    var cubit = StudentCubit.get(context);
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: "Enrolled Courses".tr,
              hasActions: false,
            ),
            body: Padding(
              padding: EdgeInsets.all(screenWidth * .02),
              child: ConditionalBuilder(
                condition: cubit.enrolledCourses.isNotEmpty,
                builder: (context) => ListView.builder(
                    itemCount: myCourses.length,
                    itemBuilder: (context, index) {
                      return paidCourse(
                          context: context,
                          course: myCourses[index],
                          theme: theme,
                          courseProgress: progress[index]);
                    }),
                fallback: (BuildContext context) {
                  if (state is StudentGetCoursesLoadingState) {
                    return Center(
                        child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            )));
                  } else if (state is StudentGetCoursesErrorState) {
                    return Text("Ops , SomeThing went wrong".tr);
                  } else {
                    return Center(
                        child: Text('You are not in class yet'.tr,
                          style: font.copyWith(color: theme.primaryColor,fontSize: screenWidth*0.06),
                        ),
                    );
                  }
                },
              ),
            ),
          );
        });
  }

  // paid course item
  Widget paidCourse({
    required BuildContext context,
    required MyCourse course,
    required ThemeData theme,
    bool isReserved = false,
    bool isFavourite = false,
    required double courseProgress,
  }) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              ClassLeader(
                course: course,
              ));
        },
        child: Container(
          width: screenWidth,
          height: screenHeight / 7,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(23.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //Teacher image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: screenHeight / 10,
                    height: screenHeight / 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(course.teacherImage),
                            fit: BoxFit.cover)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.subject.tr,
                      style: font.copyWith(
                          fontSize: 18.0, color: theme.primaryColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${course.videosNumber}${'lessons'.tr}',
                      style: font.copyWith(
                          fontSize: 12.0,
                          color: theme.primaryColorDark.withOpacity(.5)),
                    ),
                  ],
                ),
                const Spacer(),
                CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 6,
                  animation: true,
                  percent: courseProgress / 100,
                  center: Text(
                    "$courseProgress%",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: theme.primaryColorDark),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: theme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
