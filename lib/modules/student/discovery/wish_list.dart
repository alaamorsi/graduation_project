import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var theme = Theme.of(context);
          var cubit = StudentCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: 'WishList'),
          body: ConditionalBuilder(
              condition: cubit.wishList.isNotEmpty,
              builder: (context) {
              return SingleChildScrollView(
                  child: Column(
                      children: cubit.wishList.map((course) {
                        int rate = 0;
                        for (var element in course.preview) {
                          rate = rate + element.rate;
                        }
                        rate = rate~/(course.preview.length);
                        return courseItem(
                            context: context,
                            course: course,
                            rate: rate,
                            color: theme.cardColor,
                            addToWishList:(){cubit.addToWishList(course);}
                        );
                      }).toList()
                  ),
                );
            },
            fallback: (context)=> Center(
                child: Text('Your WishList is Empty',
                  style: font.copyWith(color: theme.primaryColor,fontSize: 18.0),
                ),
            ),
          ),
        );
      }
    );
  }
}
