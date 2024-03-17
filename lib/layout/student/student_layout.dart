import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class StudentLayout extends StatelessWidget {
  const StudentLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context,state) {},
        builder:(context,state){
          var cubit = StudentCubit.get(context);
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
                      tabs: const [
                        GButton(
                          icon: Icons.home_outlined,
                          text: 'Home',
                        ),
                        GButton(
                          icon: Icons.dashboard_outlined,
                          text: 'Course',
                        ),
                        GButton(
                          icon: Icons.notifications,
                          text: 'Notification',
                        ),
                        GButton(
                          icon: Icons.person_outline,
                          text: 'Profile',
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
