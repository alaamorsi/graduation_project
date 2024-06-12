import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
// import 'package:graduation_project/modules/student/course_demo/course_comments.dart';
// import 'package:graduation_project/modules/student/course_demo/course_lessons.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../shared/component/constant.dart';

class CourseDemo extends StatelessWidget {
  final CourseModel course;
  const CourseDemo({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    var theme =Theme.of(context);
    ImageProvider<Object> image=const AssetImage("Assets/profile/man_1.png");
    if(course.instProfilePicture!=null){
      Uint8List picture = base64Decode(course.instProfilePicture as String);
      image = MemoryImage(picture);
    }
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
            appBar:secondAppbar(
              context: context,
              title:course.subject.tr,
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
                            Text("Instructor : ".tr, style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark),),
                            Text("Sameh",style: font.copyWith(fontSize: 18.0,color: theme.primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("${"for level".tr} ${"primary".tr}",
                          style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark.withOpacity(.7)),
                        ),
                        const SizedBox(height: 20),
                        Text("Description".tr, style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
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
                              Text('${course.lessonsNumber} ${'lessons'.tr}', style: font.copyWith(fontSize:20.0,color: theme.primaryColorDark),),
                              const Spacer(),
                              TextButton(onPressed: () {
                                // navigateTo(context, CourseLessons(course: course));
                                },
                                child: Text('See all'.tr, style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                        const SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            navigateTo(context, const ViewVideoScreen(introUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            width: screenWidth,
                            height: screenHeight/8,
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(.1),
                              borderRadius: const BorderRadius.all(Radius.circular(23.0),),
                            ),
                            child:Row(
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
                                        image: image,
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
                        const SizedBox(height: 20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Rate And Review'.tr, style: font.copyWith(fontSize:20.0,color: theme.primaryColorDark),),
                              const Spacer(),
                              TextButton(onPressed: () {
                                // navigateTo(context, CourseComments(course: course));
                                },
                                child: Text('See all'.tr, style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: usedButton(
                      atEnd: false,
                      isLoading: state is PaymentManagerLoadingState,
                      text: '${"Enroll".tr}-${course.price}${'EGP'.tr}',
                      color: theme.cardColor,
                      radius: 30,
                      paddingSize: 10,
                      context: context,
                      onPressed:(){
                        cubit.payManager(course.price,'${CacheHelper.getData(key: 'id')},${course.courseId},${course.price}');
                        },
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
