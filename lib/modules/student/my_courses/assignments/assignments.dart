import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'showAssignment.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../shared/component/constant.dart';

class AssignmentsScreen extends StatelessWidget{
  final CourseModel course;
  const AssignmentsScreen({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context,state) {},
        builder:(context,state){
          var cubit = StudentCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "assignments".tr),
            body: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: ConditionalBuilder(
                condition: cubit.assignments.isNotEmpty,
                builder: (BuildContext context) => ListView.builder(
                  itemBuilder: (BuildContext context, int index)=> assignmentItem(assignment: cubit.assignments[index],theme: theme),
                  itemCount: cubit.assignments.length,),
                fallback: (BuildContext context) =>
                  ConditionalBuilder(
                    condition: cubit.assignments.isEmpty,
                    builder: (BuildContext context)=> Center(child: Text("There are not Assignments yet",
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
                  ),
              ),
            ),
          );
        }
    );
  }

  Widget assignmentItem({
    required AssignmentModel assignment,
    required ThemeData theme,
  })
  {
    return InkWell(
      onTap: (){
        Get.to(()=>ShowAssignmentScreen(assignment: assignment,));
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth*.02),
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColorLight.withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text(assignment.description,
                  style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                ),
                const SizedBox(height: 5,),
                Text(assignment.deadLine,
                  style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
