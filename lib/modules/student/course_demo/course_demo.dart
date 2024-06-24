import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/modules/student/my_courses/course_leader.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../shared/component/constant.dart';
import 'course_comments.dart';
import 'course_lessons.dart';

class CourseDemo extends StatefulWidget {
  final CourseModel course;
  const CourseDemo({super.key,required this.course});

  @override
  State<CourseDemo> createState() => _CourseDemoState();
}

class _CourseDemoState extends State<CourseDemo>{
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    var theme =Theme.of(context);
    String url='';
    String time = cubit.courseDetails.period.split('.')[0];
    ImageProvider<Object> image = iWillReturnImage(widget.course.instProfilePicture);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){
        if(state is PaymentManagerSuccessState){
          showToast(title: "Course Addition".tr, description: "Course has been added successfully".tr, state: MotionState.success, context: context);
          Get.off(()=> ClassLeader(course:widget.course));
        }
        else if(state is PaymentManagerErrorState){
          showToast(title: "Course Addition".tr, description: "Sorry, something went wrong during payment process".tr, state: MotionState.error, context: context);
        }
      },
      builder: (context , state ){
        return Scaffold(
            appBar:secondAppbar(
              context: context,
              title:widget.course.subject.tr,
            ),
            body: ConditionalBuilder(
              condition: state is GetCoursesDetailsSuccessState || cubit.courseDetails.instructorName.isNotEmpty,
              builder: (context)=>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              Text("Instructor : ".tr, style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark),),
                              Text(cubit.courseDetails.instructorName,style: font.copyWith(fontSize: 18.0,color: theme.primaryColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text("${"for level".tr} : ${cubit.courseDetails.academicLevel.tr}",
                            style: font.copyWith(fontSize: 18.0,color: theme.primaryColorDark.withOpacity(.9)),
                          ),
                          const SizedBox(height: 20),
                          Text('Description'.tr, style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                          Text(
                            cubit.courseDetails.courseDescription,
                            style: font.copyWith(fontSize: 13.0,color: theme.primaryColorDark.withOpacity(.5)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${widget.course.lessonsNumber} ${'lessons'.tr}', style: font.copyWith(fontSize:20.0,color: theme.primaryColorDark),),
                                const Spacer(),
                                TextButton(onPressed: () {
                                  cubit.getLessons(widget.course.courseId);
                                  navigateTo(context, CourseLessons(
                                    image: image,
                                    url: url,
                                    course: widget.course,
                                  ));
                                },
                                  child: Text('See all'.tr, style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                          const SizedBox(height: 10,),
                          if(cubit.courseDetails.lessonName.isNotEmpty||cubit.courseDetails.lessonName!='')
                            InkWell(
                              onTap: (){
                                url = cubit.courseDetails.url.substring(8);
                                url = 'https://digitutors.runasp.net/$url';
                                print(url);
                                navigateTo(context, ViewVideoScreen(introUrl: url,));
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
                                          child: Text("1. ${cubit.courseDetails.lessonName} ",
                                            style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Expanded(
                                          child: Text(
                                            time,
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
                                  navigateTo(context, CourseComments(course: cubit.courseDetails));
                                },
                                  child: Text('See all'.tr, style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                          const SizedBox(height: 10,),
                          ConditionalBuilder(
                            condition: cubit.courseDetails.reviews.isNotEmpty,
                            builder: (BuildContext context) {
                              ImageProvider<Object> reviewImage = iWillReturnImage(cubit.courseDetails.reviews[0].profilePicture);
                              return Container(
                                width: screenWidth,
                                height: screenHeight/8,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withOpacity(.1),
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
                                            image: DecorationImage(
                                              image: reviewImage,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cubit.courseDetails.reviews[0].studentName,
                                            style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(
                                            child: Text(
                                              cubit.courseDetails.reviews[0].feedback,
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
                                                  "${cubit.courseDetails.reviews[0].rateValue}",
                                                  style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            fallback: (BuildContext context)=>Center(child: Text(
                              "There is no reviews yet",
                              style: font.copyWith(color: theme.primaryColorDark,fontSize: 16),
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
                        isLoading: state is PaymentManagerLoadingState,
                        text: '${"Enroll".tr}-${widget.course.price}${'EGP'.tr}',
                        color: theme.cardColor,
                        radius: 30,
                        paddingSize: 10,
                        context: context,
                        onPressed:(){
                          cubit.payManager(widget.course.price,'buyCourse,${CacheHelper.getData(key: 'id')},${widget.course.courseId},${widget.course.price}',widget.course);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
            ),
        );
      },
    );
  }
}
