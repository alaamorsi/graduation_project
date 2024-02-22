import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/search_screen.dart';
import 'package:graduation_project/modules/settings.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../shared/component/constant.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class StudentLayout extends StatelessWidget {
  const StudentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ( context) => StudentCubit(),
      child: BlocConsumer<StudentCubit,StudentStates>(
        listener: (context,state) {},
        builder:(context,state){
          var cubit = StudentCubit.get(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: defaultAppBar(
                context: context,
                leadingIcon: Icons.search_outlined,
                leadingFunction: (){navigateTo(context, const SearchScreen());},
                title: Image(image: AssetImage(appBarLogo)),
                atEndIcon:  Icons.settings,
                atEndFunction:() {
                  navigateTo(context, const SettingsScreen());
                },
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              height: 81.0,
                index: cubit.currentIndex,
                items: [
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.explore_rounded,color: Colors.white,),
                      label: 'استكشاف',
                    labelStyle: font.copyWith(color: Colors.white,fontSize: 15.0)
                  ),
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.dashboard,color: Colors.white,),
                      label: 'كورساتي',
                    labelStyle: font.copyWith(color: Colors.white,fontSize: 15.0)
                  ),
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.person,color: Colors.white,),
                      label: 'البروفايل',
                    labelStyle: font.copyWith(color: Colors.white,fontSize: 15.0)
                  ),
                ],
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
                buttonBackgroundColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
                backgroundColor: Colors.transparent,
                animationCurve: Curves.ease,
                animationDuration: const Duration(milliseconds: 600),
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
                letIndexChange: (index) => true,
            ),
          );
        },
      ),
    );
  }
}