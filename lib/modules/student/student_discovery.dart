import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components.dart';
class StudentDiscovery extends StatefulWidget {

  @override
  State<StudentDiscovery> createState() => _StudentDiscoveryState();
}

class _StudentDiscoveryState extends State<StudentDiscovery> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index)=>Column(
            children: [
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  height: screenHeight/13.5,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.arrow_back_outlined,color: Theme.of(context).iconTheme.color,),
                        Spacer(),
                        Text(categories[index],style: Theme.of(context).textTheme.titleMedium,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: screenHeight / 4,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index)=>buildDiscoveryItem(context: context, index: index),
                    separatorBuilder: (context , index)=>SizedBox(width: 5.0,),
                    itemCount: 10
                ),
              ),
            ],
          ),
          separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 10.0,),
          itemCount: 5,
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
  }
}
