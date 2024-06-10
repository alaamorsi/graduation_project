import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../shared/component/test.dart';

class SpecialSubjectPage extends StatelessWidget {
  final String subjectName;
  const SpecialSubjectPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        var cubit = StudentCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: subjectName.tr),
          // body:  ListView.builder(
          //   shrinkWrap: true,
          //   itemBuilder:(context,index){
          //     int rate = 0;
          //     for (var element in courses[index].review) {
          //       rate = rate + element.rate;
          //     }
          //     rate = rate~/(courses[index].review.length);
          //     return courseItem(
          //       context: context,
          //       course: courses[index],
          //       rate: rate,
          //       color: theme.cardColor,
          //       addToWishList:(){cubit.addToWishList(courses[index]);}
          //     );
          //   },
          //   itemCount: 0,
          // ),
        );
      },
    );
  }
}
