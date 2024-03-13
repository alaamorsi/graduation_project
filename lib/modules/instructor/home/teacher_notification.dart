import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class Teacher_Notifications extends StatelessWidget {
  const Teacher_Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var theme = Theme.of(context);
          var cubit = StudentCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: 'Notifications'),
            body: ConditionalBuilder(
              condition: cubit.wishList.isNotEmpty,
              builder: (context) {
                return const SingleChildScrollView(
                  child: Column(
                      children: [

                      ]
                  ),
                );
              },
              fallback: (context)=> Center(
                child: Text("You don't have Notifications yet",
                  style: font.copyWith(color: theme.primaryColor,fontSize: 18.0),
                ),
              ),
            ),
          );
        }
    );
  }
}
