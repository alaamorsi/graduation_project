import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';

class ClassLeader extends StatelessWidget {
  final MyCourse course;
  const ClassLeader({super.key,required this.course});

  @override Widget build(BuildContext context) {
    return BlocProvider<CourseCubit>(
      create: (BuildContext context)=>CourseCubit(),
      child:BlocConsumer<CourseCubit,CourseStates>(
          listener: (context,state) {},
          builder:(context,state){
            var cubit = CourseCubit.get(context);
            cubit.openCourse(course);
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
                            icon: Icons.video_collection,
                            text: 'Lessons',
                          ),
                          GButton(
                            icon: Icons.chat_rounded,
                            text: 'Chats',
                          ),
                          GButton(
                            icon: Icons.assignment,
                            text: 'Assignments',
                          )
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
        ),
    );
  }
}
