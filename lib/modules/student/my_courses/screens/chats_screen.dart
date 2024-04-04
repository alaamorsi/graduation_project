import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../../shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';
import 'chat_screen.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<CourseCubit,CourseStates>(
        listener: (context,state) {},
        builder:(context,state){
          var course = CourseCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "Chat".tr),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index)=>
                  buildChatItem(
                      context: context,
                      index: index,
                      course: course.openedCourse,
                      theme: theme,
                      onTap: () {
                        Get.to(()=> const LessonChatScreen());
                      },
                  ),
              itemCount: course.openedCourse.videosNumber,
            ),
          );
        }
    );
  }
  Widget buildChatItem({
    required BuildContext context,
    required int index,
    required MyCourse course,
    required ThemeData theme,
    required void Function() onTap,
  })
  {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 6),
        child: Container(
          width: screenWidth,
          height: screenHeight/6,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(23.0),),
          ),
          child:Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(course.lessons[index].lessonName,
                  style: font.copyWith(fontSize: 23.0,fontWeight: FontWeight.w600,color: theme.primaryColorLight),
                ),
                const Spacer(),
                Icon( Icons.arrow_forward_ios,color: theme.primaryColorLight,size: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}