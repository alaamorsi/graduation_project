import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../../shared/component/constant.dart';

class AddLessons extends StatelessWidget {
  final int courseId;
  const AddLessons({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {
        if(state is AddLessonSuccessState){
          showToast(title: "Success".tr, description: "lesson has been added successfully".tr, state: MotionState.success, context: context);
          InstructorCubit.get(context).getLessons(courseId);
          Get.back();
        }
        if(state is AddLessonErrorState){
          showToast(title: "Error".tr, description: "Something went wrong".tr, state: MotionState.error, context: context);
        }
      },
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "addLessons".tr,
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    cursorColor: theme.primaryColor,
                    textAlign: TextAlign.start,
                    maxLength: 100,
                    maxLines: 5,
                    minLines: 1,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'PleaseEnterTheLessonName'.tr;
                      }
                      return null;
                    },
                    style: TextStyle(color: theme.primaryColor, fontSize: 16.0),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(.1),
                      hintText: "LessonName".tr,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(
                            color: theme.primaryColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9),
                        borderSide: BorderSide(
                          color: theme.primaryColorDark,
                          width: .8,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await cubit.pikeVideoFromGallery();
                    },
                    child: Container(
                      height: screenWidth*.45,
                        margin: EdgeInsets.symmetric(vertical: screenHeight * .01,horizontal: screenWidth*.23),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * .02),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("addFromGallery".tr, style: font.copyWith(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              // const SizedBox(width: 10,),
                              Icon(Icons.video_collection,
                                  color: theme.primaryColor, size: 30)
                            ]
                        )
                    ),
                  ),
                  const Spacer(),
                  usedButton(
                      text: 'Upload'.tr,
                      color: theme.primaryColor,
                      isLoading: state is AddLessonLoadingState,
                      atEnd: false,
                      context: context,
                      paddingSize: 20,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.addLesson(courseId: courseId, name: nameController.text, video: cubit.video, period: cubit.videoPeriod);
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
