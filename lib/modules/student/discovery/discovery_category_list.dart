import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        var theme= Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: "New Courses"),
          body: SingleChildScrollView(
            child: Column(
                children: courses.map((e) => paidCourse(
                    context: context,
                    course: e,
                    color: theme.cardColor
                )).toList()
            ),
          ),
        );
      },
    );
  }
}
