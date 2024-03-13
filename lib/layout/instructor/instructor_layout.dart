import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../modules/settings/settings.dart';
import '../../modules/instructor/home/teacher_notification.dart';
import '../../shared/component/components.dart';
import '../../shared/component/constant.dart';
import '../../shared/network/cache_helper.dart';
import '../student/cubit/cubit.dart';
import 'instructor_cubit/instructor_cubit.dart';
import 'instructor_cubit/instructor_states.dart';

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
          appBar: specialAppBar(context, cubit.currentIndex, theme),
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
                        icon: Icons.home_rounded,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.dashboard_rounded,
                        text: 'Course',
                      ),
                      GButton(
                        icon: Icons.person,
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
  PreferredSizeWidget specialAppBar(BuildContext context,int index,ThemeData theme){
    if(index==0) {
      return AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        toolbarHeight: 70.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),
        title: Text('Hello,Mr ${CacheHelper.getData(key: 'firstName')}!',
          style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
        ),
        actions:[

          Padding(padding: const EdgeInsets.symmetric(horizontal:10.0),
            child:Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              ),
              child: IconButton(
                onPressed: (){navigateTo(context, const Teacher_Notifications());},
                icon: Icon(Icons.notifications,size: 25,color: Theme.of(context).primaryColor,),
              ),
            ),
          ),
        ],
      );
    }
    else if(index==1){
      return defaultAppBar(context: context,title: Text("Course",
        style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
      ),);
    }
    else{
      return AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        toolbarHeight: 70.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),
        title: Text(StudentCubit.get(context).titles[StudentCubit.get(context).currentIndex],
          style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
        ),
        actions:[
          Padding(padding: const EdgeInsets.only(right:20.0),
            child:Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              ),
              child: IconButton(
                onPressed: (){navigateTo(context, const SettingsScreen());},
                icon: Icon(Icons.settings,size: 25,color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      );
    }
  }

}
