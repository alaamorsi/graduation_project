import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/discovery_category_list.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/constant.dart';

class StudentDiscovery extends StatefulWidget {
  const StudentDiscovery({super.key});

  @override
  State<StudentDiscovery> createState() => _StudentDiscoveryState();
}

class _StudentDiscoveryState extends State<StudentDiscovery> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'الأكثر تقييماً',
      'الأعلى مبيعاً',
      'قد يهمك',
      'محتوي اسبوعي',
      'محتوي مسجل',
    ];
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
                decoration: BoxDecoration(
                  color: HexColor("#101010").withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.arrow_back_outlined,color: HexColor("#008080"),),
                      const Spacer(),
                      Text(categories[index],
                        style: TextStyle(color: HexColor("#008080"),fontSize: 18.0,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 4,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context , index)=> buildDiscoveryItem(context: context, index: index),
                separatorBuilder: (context , index)=>const SizedBox(width: 5.0,),
                itemCount: 5,
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
