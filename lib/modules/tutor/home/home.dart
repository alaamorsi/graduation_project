import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/tutor/home/courses/courses.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import 'add_course/select_course_type.dart';

class TutorHomeScreen extends StatelessWidget {
  const TutorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cubit = InstructorCubit.get(context);
    cubit.getCourses();
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Your courses'.tr,
              hasActions: false,
            ),
            body: ConditionalBuilder(
              condition: cubit.insCourses.isNotEmpty,
              builder: (context) => ListView.builder(
                itemBuilder: (BuildContext context, int index) => courseDesign(
                    theme: theme,
                    context: context,
                    course: cubit.insCourses[index]),
                itemCount: cubit.insCourses.length,
              ),
              fallback: (BuildContext context) => ConditionalBuilder(
                condition: state is GetInstCoursesLoadingState,
                builder: (context) => Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                ),
                fallback: (BuildContext context) {
                  if (state is GetInstCoursesErrorState) {
                    return Center(
                      child: Text(
                        'Ops , SomeThing went wrong',
                        style: font.copyWith(
                            color: Colors.grey,
                            fontSize: screenWidth * 0.06),
                      ),
                    );
                  } else{
                    return Center(
                      child: Text(
                        'There are no courses yet',
                        style: font.copyWith(
                            color: theme.primaryColor,
                            fontSize: screenWidth * 0.06),
                      ),
                    );
                  }
                },
              ),
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Get.to(() => const SelectCourseType());
                    },
                    backgroundColor: theme.primaryColor,
                    tooltip: 'Create a new course'.tr,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget courseDesign({
    required ThemeData theme,
    required BuildContext context,
    required InstructorCourseModel course,
  }) {
    return InkWell(
      onTap: () {
        Get.to(TutorCoursesScreen(
          course: course,
        ));
        InstructorCubit.get(context)
            .showPopMassage(context, course.isPublished, course.courseId);
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: screenWidth,
        height: screenHeight / 5,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.4),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                  //image
                  Container(
                    width: screenHeight / 9,
                    height: screenHeight / 9,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'Assets/subjects_icon/${course.courseName}.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          course.courseName.tr,
                          style:
                              font.copyWith(fontSize: 23.0, color: Colors.white),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rate_rounded,
                              color: course.averageRate > 0
                                  ? HexColor("FDBD01")
                                  : Colors.white,
                              size: 30,
                            ),
                            Text(
                              course.averageRate > 0
                                  ? '${course.averageRate}'
                                  : '--',
                              style: font.copyWith(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            course.studentCount > 1
                                ? const Icon(
                                    Icons.groups,
                                    color: Colors.white,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 27,
                                  ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${course.studentCount} ${'subscriber'.tr}',
                              style: font.copyWith(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
