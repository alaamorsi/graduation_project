import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/course_demo/course_lessons.dart';
import 'package:graduation_project/modules/student/course_demo/view_video_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';

class Demo extends StatelessWidget {
  final Course course;
  const Demo({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    var theme =Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(course.teacherImage),fit: BoxFit.fill)
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 7.0),
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: theme.primaryColorLight.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: IconButton(
                          onPressed: (){Navigator.pop(context);},
                          icon: Icon(Icons.arrow_back_ios,size: 20,color: Theme.of(context).primaryColorLight,),
                        ),
                      ),
                      const SizedBox(width: 30,),
                      Text("${course.subject} course",
                        style: font.copyWith(fontSize: 22.0,color: theme.primaryColorLight),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight/5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(course.teacherName, style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                            const Spacer(),
                            Text("EP-${course.price}",style: font.copyWith(fontSize: 20.0,color: theme.primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(course.eduLevel, style: font.copyWith(fontSize: 16.0,color: Colors.black.withOpacity(.7),),),
                        const SizedBox(height: 11),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            rate(rate: course.review[1].rate.toDouble() ),
                            const SizedBox(width: 10,),
                            Text(
                              '( ${course.review[1].rate.toDouble()} )',
                              style: font.copyWith(fontSize: 13.0,color: Colors.black.withOpacity(.5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text("Description", style: font.copyWith(fontSize: 22.0,color: theme.primaryColorDark),),
                        Text(
                          "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description ",
                          style: font.copyWith(fontSize: 13.0,color: Colors.black.withOpacity(.3)),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 15),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('${course.videosNumber} Lessons',
                                style: font.copyWith(color: theme.primaryColorDark,fontSize: 22.0,),
                              ),
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
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                cubit.checkFavorite();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: theme.scaffoldBackgroundColor,
                                  border: Border.all(color: Colors.grey,width: .5),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child:cubit.isFavorite? const Icon( Icons.favorite) : const Icon(Icons.favorite_border),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: usedButton(
                                atEnd: false,
                                text: "Enroll - EP${course.price}",
                                color: theme.cardColor,
                                radius: 10,
                                paddingSize: 10,
                                context: context,
                                onPressed:(){},
                              ),
                            ),
                          ],
                        ),

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
}
