import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/constant.dart';

class AddDescription extends StatelessWidget {
  final InstructorCourseModel course;
  const AddDescription({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();
    descriptionController.text = course.description;
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {
        if(state is AddDescriptionSuccessState){
          showToast(title: "Success".tr, description: "description has been added successfully".tr, state: MotionState.success, context: context);
          Get.back();
        }
        if(state is AddDescriptionErrorState){
          showToast(title: "Error".tr, description: "Something went wrong".tr, state: MotionState.error, context: context);
        }
      },
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Edit".tr,
            hasAction: false,
          ),
          body: Padding(
            padding: EdgeInsets.all(screenWidth * .05),
            child: Column(
              children: [
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  cursorColor: theme.primaryColor,
                  textAlign: TextAlign.start,
                  maxLength: 100,
                  maxLines: 5,
                  minLines: 1,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter course description'.tr;
                    }
                    return null;
                  },
                  style: TextStyle(color: theme.primaryColor, fontSize: 16.0),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(.1),
                    hintText: "enterCourseDescription".tr,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                          color: theme.primaryColorDark, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: theme.primaryColorDark,
                        width: .8,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: theme.primaryColorDark,
                        width: .8,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                usedButton(
                    text: 'addDescription'.tr,
                    color: theme.primaryColor,
                    isLoading: state is AddDescriptionLoadingState,
                    atEnd: false,
                    context: context,
                    paddingSize: 20,
                    onPressed: () {
                      cubit.addDescription(course.courseId, descriptionController.text);
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
