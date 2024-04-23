import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar: secondAppbar(context: context, title: "Special".tr),
          body:  ListView(
            shrinkWrap: true,
            children: [

            ],
          ),
        );
      },
    );
  }
}
