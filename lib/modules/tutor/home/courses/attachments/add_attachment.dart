import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../../../shared/component/components.dart';

class AddAttachmentScreen extends StatelessWidget {
  final int courseId;

  const AddAttachmentScreen({super.key, required this.courseId,});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController descriptionController = TextEditingController();
    var cubit = InstructorCubit.get(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(context: context, title: "Assignment".tr),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<InstructorCubit, InstructorStates>(
              listener: (context, state) {
                if(state is AddAttachmentSuccessState){
                  cubit.getAttachments(courseId);
                  showToast(title: "Success".tr, description: "Attachment has been added successfully".tr, state: MotionState.success, context: context);
                  Get.back();
                } else if(state is AddAttachmentErrorState){
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
                        "Description",
                        style: font.copyWith(
                            color: theme.primaryColor, fontSize: 18),
                      ),
                      SizedBox(height: screenHeight * .005),
                      specificFormField(
                          controller: descriptionController,
                          theme: theme,
                          example: "(Chapter 1)",
                          message: "AddAttachmentDescription",
                          type: TextInputType.text),
                      SizedBox(height: screenHeight * .005),
                      Text(
                        "AddFile",
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
                                Icons.attach_file,
                                color: theme.primaryColor,
                                size: screenWidth * .2,
                              ),
                              onPressed: () async {
                                // cubit.pickFile();
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
                          isLoading: state is AddAttachmentLoadingState,
                          radius: 5,
                          atEnd: false,
                          text: 'Add'.tr,
                          color: theme.cardColor,
                          context: context,
                          onPressed: () {
                            cubit.addAttachment(
                                courseId,
                                descriptionController.text,
                                cubit.pickedFile);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              })
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
