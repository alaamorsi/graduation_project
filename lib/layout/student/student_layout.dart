import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/discovery/wish_list.dart';
import 'package:graduation_project/modules/student/profile/settings.dart';
import 'package:graduation_project/modules/student/discovery/notification.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
          var theme = Theme.of(context);
          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: studentAppBar(context: context, index: cubit.currentIndex, cubit: cubit, firstName: 'omer'),
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
                          text: 'Courses',
                        ),
                        GButton(
                          icon: Icons.search,
                          text: 'Search',
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
      ),
    );
  }
  PreferredSizeWidget studentAppBar({
    required BuildContext context,
    required int index,
    required var cubit,
    required String firstName,
  }){
    var theme = Theme.of(context);
    if(index==0){
      return AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        toolbarHeight: 70.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),
        title: Text('Hello,$firstName!',
            style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
        ),
        actions:[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(9.0)),
            ),
            child: IconButton(
              onPressed: (){navigateTo(context, const NotificationsScreen());},
              icon: Icon(Icons.notifications,size: 25,color: Theme.of(context).primaryColor,),
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal:10.0),
            child:Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              ),
              child: IconButton(
                onPressed: (){navigateTo(context, const WishListScreen());},
                icon: Icon(Icons.favorite,size: 25,color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      );
    } else if(index==1){
      return defaultAppBar(context: context,title: Text(cubit.titles[cubit.currentIndex],
          style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
      ),);
    } else if(index==2){
      TextEditingController searchController = TextEditingController();
      return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 70.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(11.0),
            bottomRight: Radius.circular(11.0),
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
        titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
        title: TextField(
          controller: searchController,
          textAlign: TextAlign.start,
          decoration:  InputDecoration(
            labelStyle: font.copyWith(fontSize: 14.0,color: Theme.of(context).primaryColorDark),
            hintText: 'enter teacher name or subject',
            hintStyle: const TextStyle(color: Colors.grey,fontSize: 13.0,fontWeight: FontWeight.w300),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
          ),
          keyboardType: TextInputType.text,
          onChanged: (value){},
          onSubmitted: (value) {},
        ),
        actions:[
          Padding(padding: const EdgeInsets.only(right: 13.0),
            child:Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
              ),
              child: IconButton(
                onPressed: (){cubit.showSearchFilter(context);},
                icon: Icon(Icons.filter_alt_rounded,size: 25,color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      );
    } else{
      return AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        toolbarHeight: 70.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )
        ),
        title: Text(cubit.titles[cubit.currentIndex],
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
