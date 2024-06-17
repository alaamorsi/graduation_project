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
      listener: (context, state) {},
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
              child: ListView(
                children: [
                  defaultFormField(context: context,
                      controller: nameController,
                      type: TextInputType.text,
                      radius: 9,
                      width: 1,
                      validate: (s){
                        if(s!.isEmpty) {
                          return "PleaseEnterTheLessonName";
                        }
                      },
                      label: "LessonName"),
                  InkWell(
                    onTap: () async {
                      await cubit.pikeVideoFromGallery();
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * .01),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("addFromGallery", style: font.copyWith(
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
                  SizedBox(height: screenHeight*.6,),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.addLesson(courseId: courseId, name: nameController.text, video: cubit.video, period: cubit.videoPeriod);
                      }
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * .01),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * .02),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor
                              .withOpacity(0.3),
                          borderRadius: const BorderRadius.all(Radius.circular(
                              9.0)),
                        ),
                        child: Text(
                          "Upload".tr, style: font.copyWith(color: theme
                            .primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),)
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//                      InkWell(
//                         onTap: () async{
//                           await cubit.pikeVideoFromCamera();
//                         },
//                         child: Padding(padding: const EdgeInsets.all(10.0),
//                           child:Container(
//                               height: 43,
//                               padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 3),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor.withOpacity(0.3),
//                                 borderRadius: const BorderRadius.all(Radius.circular(9.0)),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text("From camera",style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
//                                   const SizedBox(width: 10,),
//                                   Icon(Icons.camera,color: theme.primaryColor,size: 30)
//                                 ]
//                               )
//                           ),
//                         ),
//                       ),