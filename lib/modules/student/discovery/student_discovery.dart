import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/discovery/discovery_category_list.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/component/test.dart';

class StudentDiscovery extends StatelessWidget {
  const StudentDiscovery({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'الأكثر تقييماً',
      'الأعلى مبيعاً',
      'قد يهمك',
      'محتوي اسبوعي',
      'محتوي مسجل',
    ];
    var theme = Theme.of(context);
    return ConditionalBuilder(
      condition: true,
      builder: (context) => ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index)=>Column(
          children: [
            InkWell(
              onTap: (){
                navigateTo(context, CategoryList(pageName: categories[index]));
              },
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                width: double.infinity,
                height: screenHeight/13.5,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_back_outlined,color: theme.primaryColor,),
                      const Spacer(),
                      Text(categories[index],
                        style: TextStyle(color: theme.primaryColor,fontSize: 18.0,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight/3,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context , index)=> buildDiscoveryItem(
                  context: context,
                  courseTeacherImage: courses[index].teacherImage,
                  courseTeacherName: courses[index].teacherName,
                  courseSubject: courses[index].subject,
                  courseEduLevel: courses[index].eduLevel,
                  courseTerm: courses[index].term,
                  courseYear: courses[index].year,
                  courseVideosNumber: courses[index].videosNumber,
                  cardColor: theme.primaryColor,
                ),
                separatorBuilder: (context , index)=>const SizedBox(width: 10.0,),
                itemCount: courses.length,
              ),
            ),
          ],
        ),
        separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 5.0,),
        itemCount: 5,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );
  }
}
