import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../../../shared/component/components.dart';

class AddAssignmentScreen extends StatelessWidget {
  final int courseId;

  const AddAssignmentScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController descriptionController = TextEditingController();
    TimeOfDay? time = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    TextEditingController gradeController = TextEditingController();
    var theme = Theme.of(context);
    var cubit = InstructorCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(context: context, title: "AddAssignment".tr),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * .05),
        child: BlocConsumer<InstructorCubit, InstructorStates>(
            listener: (context, state) {
              if(state is AddAssignmentSuccessState){
                cubit.clear();
                cubit.getAssignments(courseId);
                showToast(title: "Success".tr, description: "Assignment has been added successfully".tr, state: MotionState.success, context: context);
                Get.back();
              } else if(state is AddAssignmentErrorState){
                showToast(title: "Error".tr, description: "Something went wrong".tr, state: MotionState.error, context: context);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description".tr,
                      style: font.copyWith(
                          color: theme.primaryColor, fontSize: 18),
                    ),
                    SizedBox(height: screenHeight * .005),
                    specificFormField(
                        controller: descriptionController,
                        theme: theme,
                        example: "(Assignment N.1)",
                        message: "AddAssignmentDescription".tr,
                        type: TextInputType.text),
                    SizedBox(height: screenHeight * .005),
                    Text(
                      "DeadLine".tr,
                      style: font.copyWith(
                          color: theme.primaryColor, fontSize: 18),
                    ),
                    SizedBox(height: screenHeight * .011),
                    InkWell(
                      onTap: ()async{
                        time  = await cubit.showTime(context, time);
                      },
                      child: Container(
                        height: screenHeight*.11,
                        padding: EdgeInsets.symmetric(horizontal: screenWidth*.1),
                        margin: EdgeInsets.only(right: screenWidth*.5),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(time != null)Text(
                                "${time!.hour}:${time!.minute}",
                              style: font.copyWith(color: theme.primaryColorDark,fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .011),
                    Text(
                      "Grade".tr,
                      style: font.copyWith(
                          color: theme.primaryColor, fontSize: 18),
                    ),
                    SizedBox(height: screenHeight * .011),
                    specificFormField(
                        controller: gradeController,
                        theme: theme,
                        example: "10",
                        message: "AddAssignmentGrade".tr,
                        maxLength: null,
                        type: TextInputType.number),
                    SizedBox(height: screenHeight * .011),
                    Text(
                      "AddFile".tr,
                      style: font.copyWith(
                          color: theme.primaryColor, fontSize: 18),
                    ),
                    SizedBox(height: screenHeight * .011),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (cubit.pickedFile == null) ?
                        Container(
                          height: screenWidth * .4,
                          width: screenWidth * .4,
                          decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(.3),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: IconButton(
                            icon: Icon(
                              Icons.assignment_add,
                              color: theme.primaryColor,
                              size: screenWidth * .2,
                            ),
                            onPressed: () {
                              cubit.pickFile();
                            },
                          ),
                        ):
                        selectedFile(cubit.file),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * .05),
                      child: usedButton(
                        paddingSize: screenWidth * .05,
                        radius: 5,
                        atEnd: false,
                        isLoading: state is AddAssignmentLoadingState,
                        text: 'Add'.tr,
                        color: theme.cardColor,
                        context: context,
                        onPressed: () {
                          String hours = changeNumTo2Digits(time!.hour);
                          String minutes = changeNumTo2Digits(time!.minute);
                          cubit.addAssignment(
                              courseId: courseId,
                              description:descriptionController.text,
                              grade:int.parse(gradeController.text),
                              deadLine: "$hours:$minutes:00",
                              file:cubit.pickedFile
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget specificFormField({
    required TextEditingController controller,
    required TextInputType type,
    required ThemeData theme,
    required String example,
    required String message,
    int? maxLength = 100,
    int maxLines = 5,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      cursorColor: theme.primaryColor,
      textAlign: TextAlign.start,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: 1,
      validator: (String? value) {
        if (value!.isEmpty) {
          return message.tr;
        }
        return null;
      },
      style: TextStyle(color: theme.primaryColor, fontSize: 16.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(.1),
        hintText: 'Example : '.tr + example.tr,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(color: theme.primaryColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
            color: theme.primaryColorDark,
            width: .8,
          ),
        ),
      ),
    );
  }

}
