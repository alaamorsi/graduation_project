// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/components.dart';
class StudentDiscovery extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return ConditionalBuilder(
        condition: true,
        builder: (context) => ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index)=>Column(
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                width: double.infinity,
                height: screenHeight/13,
                color: Theme.of(context).primaryColorLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('الأكثر تقييماً',style: TextStyle(fontSize: 20.0),),
                  ],
                ),
              ),
              Container(
                height: screenHeight / 4,
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context , index)=>buildDiscoveryItem(context , index),
                    separatorBuilder: (context , index)=>SizedBox(width: 5.0,),
                    itemCount: 10
                ),
              ),
            ],
          ),
          separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 10.0,),
          itemCount: 10,
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      );
  }
}
