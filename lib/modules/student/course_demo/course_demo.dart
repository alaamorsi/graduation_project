import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/course_demo/course_lessons.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';

class CourseDemo extends StatelessWidget {
  final Course course;
  const CourseDemo({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    var theme =Theme.of(context);
    cubit.fullPaidList(4);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
            appBar:secondAppbar(
              context: context,
              title: "${course.subject} course",
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${course.subject} course",
                      style: font.copyWith(fontSize: 22.0,color: theme.primaryColorDark),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Instructor : ", style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark),),
                        Text(course.teacherName,style: font.copyWith(fontSize: 18.0,color: theme.primaryColor),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        //   child: Container(
                        //     width: screenHeight/10,
                        //     height: screenHeight/10,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(15),
                        //       image: DecorationImage(
                        //         image:  NetworkImage(course.teacherImage),
                        //         fit: BoxFit.cover,),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("for level ${course.eduLevel} ",
                      style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark.withOpacity(.7)),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${course.videosNumber} Lessons', style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0,fontWeight: FontWeight.w300),),
                            const Spacer(),
                            TextButton(onPressed: () {navigateTo(context, CourseLessons(course: course));},
                              child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){navigateTo(context, const ViewVideoScreen());},
                      child: Container(
                        width: screenWidth,
                        height: screenHeight/8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
                          border: Border.all(color: Colors.grey,width: .1),
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
                                    child: Text("1. introduction ",
                                      style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Text(
                                      '20 mints',
                                      style: font.copyWith(fontSize: 12.0,color: Colors.black.withOpacity(.5)),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child:
                                    Icon( Icons.ondemand_video,color: theme.primaryColor,size: 30,),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('${course.videosNumber} Lessons', style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0,fontWeight: FontWeight.w300),),
                            const Spacer(),
                            TextButton(onPressed: () {navigateTo(context, CourseLessons(course: course));},
                              child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                    ),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: (){navigateTo(context, const ViewVideoScreen());},
                      child: Container(
                        width: screenWidth,
                        height: screenHeight/8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
                          border: Border.all(color: Colors.grey,width: .1),
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
                                    child: Text("1. introduction ",
                                      style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Text(
                                      '20 mints',
                                      style: font.copyWith(fontSize: 12.0,color: Colors.black.withOpacity(.5)),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child:
                                    Icon( Icons.ondemand_video,color: theme.primaryColor,size: 30,),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: usedButton(
                        atEnd: false,
                        text: "Enroll - EP${course.price}",
                        color: theme.cardColor,
                        radius: 50,
                        paddingSize: 10,
                        context: context,
                        onPressed:(){cubit.checkPayment(4);},
                      ),
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
