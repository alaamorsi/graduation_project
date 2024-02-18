import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';

import '../../shared/components.dart';

class CategoryList extends StatelessWidget {
  final String pageName;
  const CategoryList({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar:AppBar(
            toolbarHeight: 70.0,
            bottomOpacity: 0.7,
            elevation: 2.0,
            shadowColor: Colors.grey,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            leading: IconButton(
                onPressed: (){Navigator.pop(context);},
                icon: const Icon(Icons.arrow_back_ios_rounded)
            ),
            title: Text(pageName),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
                condition: true,
                builder: (context)=>ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context , index)=> buildDiscoveryItem(context: context, index: index),
                  separatorBuilder: (context , index)=>const SizedBox(width: 5.0,),
                  itemCount: 20,
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }
}
