import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var theme = Theme.of(context);
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title:"Notifications".tr,
              hasActions: false,
            ),
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
                child: Text("You don't have Notifications yet".tr,
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),
              ),
            ),
          );
        }
    );
  }
}
