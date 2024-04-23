import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'tutor_cubit/instructor_cubit.dart';
import 'tutor_cubit/instructor_states.dart';

class InstructorLayout extends StatelessWidget {
  const InstructorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InstructorCubit,InstructorStates>(
      listener: (context,state) {},
      builder:(context,state){
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: theme.primaryColorLight,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: theme.primaryColorDark.withOpacity(.1),
                        offset: const Offset(0, -5),
                      )
                    ],
                  ),
                  child: GNav(
                    hoverColor: theme.canvasColor,
                    gap: 3,
                    iconSize: 25,
                    padding: const EdgeInsets.all(9),
                    duration: const Duration(milliseconds: 500),
                    color: theme.primaryColorDark.withOpacity(0.3),//the unselected items
                    tabBackgroundColor: theme.primaryColor.withOpacity(0.2),//the tabbed item
                    tabBorderRadius: 15,
                    activeColor: theme.primaryColor,
                    tabs:  [
                      GButton(
                        icon: Icons.home_rounded,
                        text: 'Home'.tr,
                      ),
                      GButton(
                        icon: Icons.notifications,
                        text: 'Notifications'.tr,
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile'.tr,
                      ),
                    ],
                    selectedIndex: cubit.currentIndex,
                    onTabChange: (index){
                      cubit.changeBottomNav(index);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
