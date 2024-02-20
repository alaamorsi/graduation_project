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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                toolbarHeight: 70.0,
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
              ConditionalBuilder(
                condition: true,
                builder: (context)=>SliverList.builder(
                  itemBuilder: (BuildContext context, int index)=>Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: buildDiscoveryItem(context: context, index: index),
                  ),
                  itemCount: 9,
                ),
                fallback: (context)=>const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}
