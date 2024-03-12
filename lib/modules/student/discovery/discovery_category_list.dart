import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar: secondAppbar(context: context, title: "New Courses"),
          body:  ListView(
            shrinkWrap: true,
            children: [
              slideItem(context: context, title: "Learn English Easy", id: 1, image: "Assets/subjects_icon/alphabet.png"),
              slideItem(context: context, title: "Know more about History", id: 2, image: "Assets/subjects_icon/history.png"),
            ],
          ),
        );
      },
    );
  }
}
