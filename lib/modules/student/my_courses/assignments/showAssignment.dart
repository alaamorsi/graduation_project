import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/modules/show_file.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../../../shared/component/components.dart';

class ShowAssignmentScreen extends StatelessWidget {
  final AssignmentModel assignment;
  final int index;
  const ShowAssignmentScreen({super.key, required this.assignment, required this.index});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context, state) {
        if(state is AddAssignmentSolutionSuccessState){
          showToast(title: "Success".tr, description: "assignment has been submitted".tr, state: MotionState.success, context: context);
          Get.back();
        } else if(state is AddAssignmentSolutionErrorState){
          showToast(title: "Error".tr, description: "Something went wrong".tr, state: MotionState.error, context: context);
        }
      },
      builder: (context, state) {
        String extension = assignment.file.split('.')[1];
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(context: context, title: "${"Assignment".tr} $index"),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${cubit.gradeModel!.grade??""}/${assignment.grade}",
                      style: font.copyWith(
                        color: Theme
                            .of(context)
                            .cardColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${assignment.deadLine.split('T')[0]} ${assignment
                          .deadLine.split('T')[1].split('.')[0]}',
                      style: font.copyWith(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  assignment.description,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: font.copyWith(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        String url = assignment.file.substring(8);
                        url = 'https://digitutors.runasp.net/$url';
                        Get.to(() => ShowFile(url: url));
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.shade300),
                        child: Center(child: Text(".$extension",)),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                cubit.hasGrade?
                const SizedBox():
                usedButton(
                  paddingSize: 10,
                  radius: 5,
                  atEnd: false,
                  text: 'Add work'.tr,
                  color: Theme
                      .of(context)
                      .cardColor,
                  context: context,
                  onPressed: () {
                    cubit.pickFile();
                  },
                ),
                const SizedBox(height: 15.0),
                cubit.hasGrade?
                usedButton(
                  paddingSize: 10,
                  radius: 5,
                  atEnd: false,
                  text: 'submitted'.tr,
                  color: theme.primaryColor,
                  context: context,
                  onPressed: () {},
                ):
                usedButton(
                  paddingSize: 10,
                  radius: 5,
                  atEnd: false,
                  text: 'submit'.tr,
                  color: Colors.black38,
                  context: context,
                  onPressed: () {
                    cubit.uploadSolution(
                        assignmentId: assignment.id,
                        description: "description",
                        file: cubit.pickedFile
                    );
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
