import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    StudentCubit.get(context).getFavouriteList();
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var theme = Theme.of(context);
          var cubit = StudentCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: 'WishList'.tr),
          body: ConditionalBuilder(
              condition: state is GetFavouriteListSuccessState || cubit.favouriteList.isNotEmpty || state is AddToFavouriteSuccessState,
              builder: (context) {
              return cubit.favouriteList.isNotEmpty ? ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>courseItem(
                      context: context,
                      course: cubit.favouriteList[index],
                      color: theme.cardColor,
                      addToWishList:(){
                        cubit.addToFavourite(cubit.favouriteList[index]);
                      }
                  ),
                itemCount: cubit.favouriteList.length,
              ) : Center(
                child: Text('Your WishList is Empty'.tr,
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),
              );
            },
            fallback: (context)=> state is! GetFavouriteListLoadingState ? Center(
                child: Text('Something went wrong'.tr,
                  style: font.copyWith(
                      color: theme.primaryColor,
                      fontSize: screenWidth * 0.06),
                ),
            ) : const Center(child: CircularProgressIndicator()),
          ),
        );
      }
    );
  }
}
