import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/course_demo/course_comments.dart';
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
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){
      },
      builder: (context , state ){
        return Scaffold(
            appBar:secondAppbar(
              context: context,
              title: "${course.subject} course",
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
              child: Column(
                children: [
                  Flexible(
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            Text("Instructor : ", style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark),),
                            Text(course.teacherName,style: font.copyWith(fontSize: 18.0,color: theme.primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("for level ${course.eduLevel} ",
                          style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark.withOpacity(.7)),
                        ),
                        const SizedBox(height: 20),
                        Text("Description", style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                        Text(
                          "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description ",
                          style: font.copyWith(fontSize: 13.0,color: theme.primaryColorDark.withOpacity(.5)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${course.videosNumber} Lessons', style: font.copyWith(fontSize:20.0,color: theme.primaryColorDark),),
                              const Spacer(),
                              TextButton(onPressed: () {navigateTo(context, CourseLessons(course: course));},
                                child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){navigateTo(context, const ViewVideoScreen());},
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
                                        child: Text("1. introduction ",
                                          style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Expanded(
                                        child: Text(
                                          '20 mints',
                                          style: font.copyWith(fontSize: 12.0,color: Colors.grey),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Rate And Preview', style: font.copyWith(fontSize:20.0,color: theme.primaryColorDark),),
                              const Spacer(),
                              TextButton(onPressed: () {navigateTo(context, CourseComments(course: course));},
                                child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                        const SizedBox(height: 10,),
                        Container(
                          width: screenWidth,
                          height: screenHeight/8,
                          decoration: BoxDecoration(
                            color: theme.primaryColorLight.withOpacity(.2),
                            borderRadius: const BorderRadius.all(Radius.circular(15.0),),
                          ),
                          child:Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(30),
                                      image: course.preview[0].image!=null?
                                      DecorationImage(
                                        image:  NetworkImage(course.teacherImage),
                                        fit: BoxFit.cover,
                                      ):
                                      const DecorationImage(
                                        image:  AssetImage("Assets/profile_icon_S.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.preview[0].name,
                                      style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      course.preview[0].dateTime,
                                      style: font.copyWith(fontSize: 12.0,color: Colors.grey),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${course.preview[0].comment}!",
                                        style: font.copyWith(fontSize: 14.0,color: theme.primaryColorDark.withOpacity(.7)),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star_rate_rounded,
                                            size: 20.0,
                                            color:Colors.white,
                                          ),
                                          Text(
                                            '${course.preview[0].rate}',
                                            style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: usedButton(
                      atEnd: false,
                      text: "Enroll - EP${course.price}",
                      color: theme.cardColor,
                      radius: 30,
                      paddingSize: 10,
                      context: context,
                      onPressed:(){cubit.checkPayment(4);},
                    ),
                  ),
                ],
              ),
            ),
        );
      },
    );
  }
}
