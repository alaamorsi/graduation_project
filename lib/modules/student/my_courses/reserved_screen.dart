import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/student/my_courses/course_leader.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../models/courses_model.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> progress = [0, 10, 50];
    var theme = Theme.of(context);
    var cubit = StudentCubit.get(context);
    cubit.getEnrolledCourses(1);
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {
          if(state is GetCoursesEnrolledErrorState && !cubit.enrolled){
            cubit.getEnrolledCourses(1);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: "Enrolled Courses".tr,
              hasActions: false,
            ),
            body: ConditionalBuilder(
              condition: cubit.enrolledCourses.isNotEmpty,
              builder: (context)=>Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: ConditionalBuilder(
                  condition: cubit.enrolledCourses.isNotEmpty,
                  builder: (context) => ListView.builder(
                      itemCount: cubit.enrolledCourses.length,
                      itemBuilder: (context, index) {
                        return paidCourse(
                            context: context,
                            course: cubit.enrolledCourses[index],
                            theme: theme,
                            courseProgress: progress[index]);
                      }),
                  fallback: (BuildContext context) {
                    if (state is GetCoursesLoadingState) {
                      return Center(
                          child: SizedBox(
                              width: screenWidth*.2,
                              height: screenWidth*.2,
                              child: CircularProgressIndicator(
                                color: theme.primaryColor,
                              )));
                    } else if (state is GetCoursesErrorState) {
                      return Text("SomeThing went wrong".tr);
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
              fallback: (context)=>Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
            ),
          );
        });
  }

  // paid course item
  Widget paidCourse({
    required BuildContext context,
    required CourseModel course,
    required ThemeData theme,
    bool isReserved = false,
    bool isFavourite = false,
    required double courseProgress,
  }) {
    ImageProvider<Object> image = iWillReturnImage(course.instProfilePicture);
    return InkWell(
      onTap: () {
        Get.to(()=>ClassLeader(course: course,));
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth*.02),
        padding: EdgeInsets.all(screenWidth*.02),
        width: screenWidth,
        height: screenHeight * .14,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.1),
          borderRadius: const BorderRadius.all(
            Radius.circular(23.0),
          ),
        ),
        child: Stack(
          alignment:isArabic?Alignment.topLeft:Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 3),
              decoration: BoxDecoration(
                  color:theme.canvasColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Text(course.type.tr,style: font.copyWith(color: Colors.white),),
            ),
            Row(
              children: [
                //Teacher image
                Container(
                  width: screenHeight / 10,
                  height: screenHeight / 10,
                  margin: EdgeInsets.symmetric(horizontal:screenWidth*.02),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover)),
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
                      '${course.lessonsNumber}${'lessons'.tr}',
                      style: font.copyWith(
                          fontSize: 12.0,
                          color: theme.primaryColorDark.withOpacity(.5)),
                    ),
                  ],
                ),
                const Spacer(),
                CircularPercentIndicator(
                  radius: screenHeight*.05,
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
          ],
        ),
      ),
    );
  }
}
