import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var theme = Theme.of(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: 'Notifications'),
            body: ConditionalBuilder(
              condition: false,
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
