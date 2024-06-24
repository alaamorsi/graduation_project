import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../models/courses_model.dart';
import '../../../shared/component/constant.dart';

class CourseComments extends StatelessWidget {
  final CourseDetailsModel course;
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
            title: 'Rate And Review'.tr,
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
                              color: theme.primaryColor,
                              theme: theme,
                              review: course.reviews[index]
                          ),
                      separatorBuilder: (context , index)=>const SizedBox(width: double.infinity,height: 10.0,),
                      itemCount: course.reviews.length,
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
                        Text('back'.tr,style: font.copyWith(color: theme.primaryColor,fontSize: 18.0,fontWeight: FontWeight.bold),),
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
    required ReviewModel review,
    required Color color,
    required ThemeData theme,
  })
  {
    ImageProvider<Object> reviewImage = iWillReturnImage(review.profilePicture);
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image:  reviewImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  review.studentName,
                  style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: Text(
                    review.feedback,
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
                        "${review.rateValue}",
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
