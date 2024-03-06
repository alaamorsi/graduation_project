import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';

class CourseComments extends StatelessWidget {
  final Course course;
  const CourseComments({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar:secondAppbar(
            context: context,
            title: 'Rate And Preview',
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
                          buildReviewItem(
                              context: context,
                              index: index,
                              course: course,
                              color: theme.primaryColor
                          ),
                      separatorBuilder: (context , index)=>const SizedBox(width: double.infinity,height: 10.0,),
                      itemCount: course.preview.length,
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){Navigator.pop(context);},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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

  Widget buildReviewItem({
    required BuildContext context,
    required int index,
    required Course course,
    required Color color,
  })
  {
    return Container(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  image: course.preview[index].image!=null?
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
                  course.preview[index].name,
                  style: font.copyWith(fontSize: 16.0,color: Colors.black,fontWeight: FontWeight.bold),
                ),
                Text(
                  course.preview[index].dateTime,
                  style: font.copyWith(fontSize: 12.0,color: Colors.grey),
                ),
                Expanded(
                  child: Text(
                    course.preview[index].comment,
                    style: font.copyWith(fontSize: 14.0,color: Colors.black.withOpacity(.7)),
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
                    color: color,
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
                        '${course.preview[index].rate}',
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
  }
}
