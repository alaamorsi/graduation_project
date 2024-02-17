import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/search_screen.dart';
import 'package:graduation_project/modules/settings.dart';
import 'package:graduation_project/shared/components.dart';
import '../../shared/constant.dart';

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
            bottomNavigationBar: BottomNavigationBar(
              elevation: 5.0,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              iconSize: 30.0,
              unselectedFontSize: 19.0,
              selectedFontSize: 21.0,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.explore_rounded),label: 'استكشاف'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'كورساتي'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'البروفايل'),
              ]
            ),
          );
        },
      ),
    );
  }
}