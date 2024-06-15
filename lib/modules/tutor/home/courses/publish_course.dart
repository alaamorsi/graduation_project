import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/constant.dart';

class PublishCourse extends StatefulWidget {
  const PublishCourse({super.key});

  @override
  State<PublishCourse> createState() => _PublishCourseState();
}

class _PublishCourseState extends State<PublishCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      InstructorCubit.get(context).isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController descriptionController = TextEditingController();
    bool hasIntro = false;
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Publish Course".tr,
            hasAction: false,
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .03),
              child: ListView(
                children: [
                  Text(
                    "Add Description".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * .05),
                  ),
                  SizedBox(height: screenWidth * .05),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.text,
                      cursorColor: theme.primaryColor,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter course description'.tr;
                        }
                        return null;
                      },
                      style:
                          TextStyle(color: theme.primaryColor, fontSize: 16.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(.1),
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
                  ),
                  SizedBox(height: screenWidth * .05),
                  Text(
                    "Upload Course Introduction".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * .05),
                  ),
                  SizedBox(height: screenWidth * .05),
                  // InkWell(
                  //   onTap: () async {
                  //     await cubit.pikeVideoFromGallery();
                  //     setState(() {
                  //       hasIntro = true;
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Container(
                  //         height: 43,
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 9, vertical: 3),
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //           color:
                  //               Theme.of(context).primaryColor.withOpacity(0.3),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(9.0)),
                  //         ),
                  //         child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Text(
                  //                 "From gallery",
                  //                 style: font.copyWith(
                  //                     color: theme.primaryColor,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 20),
                  //               ),
                  //               const SizedBox(
                  //                 width: 10,
                  //               ),
                  //               Icon(Icons.video_collection,
                  //                   color: theme.primaryColor, size: 30)
                  //             ])),
                  //   ),
                  // ),
                  if (hasIntro)
                    InkWell(
                      onTap: () {
                        setState(() {
                          hasIntro = false;
                        });
                      },
                      child: Container(
                          height: 150.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.canvasColor),
                          child: const Center(child: Text("Intro"))),
                    ),
                  SizedBox(height: screenWidth * .05),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * .05),
                    child: usedButton(
                        text: 'Publish'.tr,
                        color: theme.primaryColor,
                        isLoading: cubit.isLoading,
                        atEnd: false,
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              cubit.isPublished = true;
                               // Get.to(()=>const TutorCoursesScreen(course: ,));
                            });
                          }
                        }),
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
