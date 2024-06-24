import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/models/lesson_model.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../shared/component/constant.dart';

class CourseLessons extends StatelessWidget {
  final CourseModel course;
  final ImageProvider<Object> image;
  final String url;
  const CourseLessons({super.key,required this.course, required this.image, required this.url});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    var cubit = StudentCubit.get(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar:secondAppbar(
            context: context,
            title: '${course.lessonsNumber} ${'lessons'.tr}',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Flexible(
                  child: ConditionalBuilder(
                    condition: cubit.lessons.isNotEmpty,
                    builder: (context)=>ListView.separated(
                      itemBuilder: (context , index)=>
                          buildLessonItem(
                              context: context,
                              index: index,
                              lesson: cubit.lessons[index],
                              theme: theme,
                          ),
                      separatorBuilder: (context , index)=>const SizedBox(width: double.infinity,height: 10.0,),
                      itemCount: course.lessonsNumber,
                    ),
                    fallback: (context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: (){Navigator.pop(context);},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.scaffoldBackgroundColor,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        side: BorderSide(color: theme.primaryColor)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Icon(Icons.arrow_back,color: theme.primaryColor,),
                          const SizedBox(width: 9,),
                          Text('Back'.tr,style: font.copyWith(color: theme.primaryColor,fontSize: 18.0,fontWeight: FontWeight.bold),),
                        ],
                      ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildLessonItem({
    required BuildContext context,
    required int index,
    required LessonModel lesson,
    required ThemeData theme,
  })
  {
    String time =lesson.period.split('.')[0];
    return InkWell(
      onTap: (){index==0?navigateTo(context, ViewVideoScreen(introUrl: url,)):null;},
      child: Container(
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(.1),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //Teacher image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: screenHeight/10,
                  height: screenHeight/10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image:  image,
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(index==0?"1. introduction":"${index+1}. ${lesson.lessonName}",
                      style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Expanded(
                    child: Text(
                      time,
                      style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: index==0?
                    Icon( Icons.ondemand_video,color: theme.primaryColor,size: 30,):
                    const Icon(Icons.lock_outline,color: Colors.grey,size: 30,),
                  ),
                ],
              ),
              const SizedBox(width: 15,),
            ],
          ),
        ),
      ),
    );
  }
}
