import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/attachment_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../shared/component/constant.dart';
import 'add_attachment.dart';

class AttachmentsScreen extends StatelessWidget{
  final InstructorCourseModel course;
  const AttachmentsScreen({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context,state) {},
        builder:(context,state){
          var theme = Theme.of(context);
          var cubit = InstructorCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "attachments".tr),
            body: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: ConditionalBuilder(
                condition: state is InstGetAttachmentsSuccessState || cubit.assignments.isNotEmpty,
                builder: (BuildContext context) =>
                cubit.attachments.isNotEmpty?
                ListView.builder(
                  itemBuilder: (BuildContext context, int index)=>
                  attachmentItem(attachment: cubit.attachments[index],theme: theme),
                  itemCount: cubit.attachments.length,):
                Center(child: Text("There are not Attachment yet",
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),),
                fallback: (BuildContext context) =>
                    ConditionalBuilder(
                      condition: state is InstGetAttachmentsErrorState,
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
                      Get.to(() => AddAttachmentScreen(courseId: course.courseId,));
                    },
                    backgroundColor: theme.primaryColor,
                    tooltip: 'addAttachment'.tr,
                    child: const Icon(
                      Icons.file_upload,
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
  Widget attachmentItem({
    required AttachmentModel attachment,
    required ThemeData theme,
  })
  {
    return InkWell(
      onTap: (){
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth*0.03),
        margin: EdgeInsets.all(screenWidth*.02),
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text(attachment.description,
                  style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
