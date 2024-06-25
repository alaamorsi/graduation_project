import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/tutor/home/courses/assignments/show_assignment.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../shared/component/constant.dart';
import 'add_assignment.dart';

class AssignmentsScreen extends StatelessWidget{
  final InstructorCourseModel course;
  const AssignmentsScreen({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit,InstructorStates>(
        listener: (context,state) {},
        builder:(context,state){
          var cubit = InstructorCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "assignments".tr),
            body: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: ConditionalBuilder(
                condition: state is InstGetAssignmentsSuccessState || cubit.assignments.isNotEmpty,
                builder: (BuildContext context) =>
                cubit.assignments.isNotEmpty?
                ListView.builder(
                  itemBuilder: (BuildContext context, int index)=> assignmentItem(assignment: cubit.assignments[index],theme: theme, cubit: cubit),
                  itemCount: cubit.assignments.length,):
                Center(child: Text("There are not Assignments yet".tr,
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),),
                fallback: (BuildContext context) =>
                  ConditionalBuilder(
                    condition:state is InstGetAssignmentsErrorState,
                    builder: (BuildContext context)=> Center(child: Text("Something went wrong".tr,
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
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
                      Get.to(() => AddAssignmentScreen(courseId: course.courseId,));
                    },
                    backgroundColor: theme.primaryColor,
                    tooltip: 'addAssignment'.tr,
                    child: const Icon(
                      Icons.assignment_add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget assignmentItem({
    required AssignmentModel assignment,
    required ThemeData theme,
    required InstructorCubit cubit,
  })
  {
    return InkWell(
      onTap: (){
        cubit.getSolutions(assignment.id);
        Get.to(()=>ShowAssignmentSolutionScreen(assignment:assignment));
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth*.02),
        padding: EdgeInsets.all(screenWidth*.03),
        width: screenWidth,
        height: screenHeight*.2,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assignment ${assignment.id}",
                  style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),
                ),
                SizedBox(width: screenWidth*.18,),
                Text("${assignment.deadLine.split('T')[0]} ",
                  style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Text(assignment.description,
              style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
            ),

            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
