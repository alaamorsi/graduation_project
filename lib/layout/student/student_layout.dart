import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/notification/notification.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

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
            bottomNavigationBar:CurvedNavigationBar(
              height: 81.0,
                index: cubit.currentIndex,
                items: [
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.explore_rounded,color: Colors.white,),
                      label: 'discovery',
                      labelStyle: font.copyWith(color: Colors.white,fontSize: 12.0)
                  ),
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.auto_awesome_mosaic,color: Colors.white,),
                      label: 'my courses',
                      labelStyle: font.copyWith(color: Colors.white,fontSize: 12.0)
                  ),
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.search,color: Colors.white,),
                      label: 'Search',
                      labelStyle: font.copyWith(color: Colors.white,fontSize: 12.0)
                  ),
                  CurvedNavigationBarItem(
                      child: const Icon(Icons.person,color: Colors.white,),
                      label: 'profile',
                      labelStyle: font.copyWith(color: Colors.white,fontSize: 12.0)
                  ),
                ],
                color: theme.primaryColor,
                buttonBackgroundColor: theme.primaryColor,
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
            style: font.copyWith(fontSize: 24.0,color: Theme.of(context).primaryColorDark),
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
                onPressed: (){},
                icon: Icon(Icons.favorite,size: 25,color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      );
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
      return defaultAppBar(context: context,title: Text(cubit.titles[cubit.currentIndex],
        style: font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColorDark,),
      ),);
    }
  }
}
// menu_book

//            bottomNavigationBar: BottomNavigationBar(
//               backgroundColor:theme.canvasColor,
//               selectedIconTheme: const IconThemeData(
//                   color: Colors.white,
//                   size: 35,
//               ),
//               unselectedIconTheme: const IconThemeData(
//                   color: Colors.grey,
//                   size: 30,
//               ),
//               selectedLabelStyle: TextStyle(color: Colors.white,),
//               items: const [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.explore_rounded),
//                     label: 'discovery',
//                     tooltip: 'discovery',
//                 ),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.auto_awesome_mosaic),
//                     label: 'my courses',
//                     tooltip: 'my courses',
//                 ),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.message),
//                     label: 'notifications',
//                     tooltip: 'notifications',
//                 ),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person),
//                     label: 'profile',
//                     tooltip: 'profile',
//                 ),
//               ],
//               currentIndex: cubit.currentIndex,
//               onTap: (index) {
//                 cubit.changeBottomNav(index);
//               },
//             ),