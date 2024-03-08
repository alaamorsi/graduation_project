import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';

class CourseLessons extends StatelessWidget {
  final Course course;
  const CourseLessons({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar:secondAppbar(
            context: context,
            title: '${course.videosNumber} Lessons',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Flexible(
                  child: ConditionalBuilder(
                    condition: true,
                    builder: (context)=>ListView.separated(
                      itemBuilder: (context , index)=>
                          buildLessonItem(
                              context: context,
                              index: index,
                              title: "lesson",
                              course: course,
                              color: theme.primaryColor,
                              theme: theme
                          ),
                      separatorBuilder: (context , index)=>const SizedBox(width: double.infinity,height: 10.0,),
                      itemCount: course.videosNumber,
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator()),
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
                          Text('Back',style: font.copyWith(color: theme.primaryColor,fontSize: 18.0,fontWeight: FontWeight.bold),),
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
    required String title,
    required Course course,
    required Color color,
    required ThemeData theme,
  })
  {
    return InkWell(
      onTap: (){index==0?navigateTo(context, const ViewVideoScreen()):null;},
      child: Container(
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColorLight.withOpacity(.2),
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
                      image:  NetworkImage(course.teacherImage),
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(index==0?"1. introduction":"${index+1}. $title",
                      style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Expanded(
                    child: Text(
                      '45 mints',
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
                    Icon( Icons.ondemand_video,color: color,size: 30,):
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
