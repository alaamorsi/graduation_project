import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/attachment_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../shared/component/constant.dart';

class AttachmentsScreen extends StatelessWidget{
  final CourseModel course;
  const AttachmentsScreen({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context,state) {},
        builder:(context,state){
          var theme = Theme.of(context);
          var cubit = StudentCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "attachments".tr),
            body: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: ConditionalBuilder(
                condition: cubit.attachments.isNotEmpty||state is GetCourseAttachmentsSuccessState,
                builder: (BuildContext context) =>
                  cubit.attachments.isNotEmpty?
                  ListView.builder(
                  itemBuilder: (BuildContext context, int index)=> attachmentItem(attachment: cubit.attachments[index],theme: theme),
                  itemCount: cubit.attachments.length,):
                  Center(child: Text("There are not Attachment yet".tr,
                    style: font.copyWith(
                        color: theme.primaryColor,
                        fontSize: screenWidth * 0.06),
                  ),),
                fallback: (BuildContext context) =>
                    ConditionalBuilder(
                      condition: state is GetCourseAttachmentsErrorState,
                      builder: (BuildContext context)=> Center(child: Text("Something went wrong".tr,
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
  Widget attachmentItem({
    required AttachmentModel attachment,
    required ThemeData theme,
  })
  {
    return InkWell(
      onTap: (){
      },
      child: Container(
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
