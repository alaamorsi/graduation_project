import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/components.dart';

class StudentLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: defaultAppBar(context: context, logo: cubit.logoImage),
          body: Container(
            width: double.infinity,
          ),
          //body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5.0,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            iconSize: 30.0,
            unselectedFontSize: 16.0,
            selectedFontSize: 17.0,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'استكشاف'),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'كورساتي'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'البروفايل'),
            ]
          ),
        );
      },
    );
  }
}