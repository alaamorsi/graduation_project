import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/instructor/home/add_course.dart';
import 'package:graduation_project/modules/instructor/home/teacher_notification.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/instructor/instructor_cubit/instructor_cubit.dart';
import '../../../layout/instructor/instructor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/network/cache_helper.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit,InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            toolbarHeight: 70.0,
            leading: const Padding(
              padding: EdgeInsets.only(
                left: 15,top: 5,bottom: 5,
              ),
              child: Image(image: AssetImage("Assets/appbar.png")),
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
                    onPressed: (){navigateTo(context, const TeacherNotifications());},
                    icon: Icon(Icons.notifications,size: 25,color: Theme.of(context).primaryColor,),
                  ),
                ),
              ),
            ],
          ),
          body:Padding(
              padding: const EdgeInsets.all(17),
              child: Wrap(
                children: [
                  dashboardItem(
                    context: context,
                    title: "Add Course",
                    image: "Assets/for_teacher/courses.png",
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Important",
                    image: "Assets/for_teacher/notes.png",
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Profits",
                    image: "Assets/for_teacher/getMoney.png",
                    goTo: (){
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Grow",
                    image: "Assets/for_teacher/statistics.png",
                    goTo: (){
                    },
                  ),
                ],
              ),
            ),
        );
      }
    );
  }
}

Widget dashboardItem({
  required BuildContext context,
  required String title,
  required String image,
  required void Function()  goTo,
}) {
  return InkWell(
    onTap:goTo,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(color: Theme.of(context).canvasColor,blurRadius: 1,spreadRadius: 1)]
        ),
        child: Column(
          children: [
            Container(
              width: screenWidth/2.6,
              padding: const EdgeInsets.only(left: 30,right: 30,top: 20,bottom: 15),
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image(image:AssetImage(image))
            ),
            Container(
              width: screenWidth/2.6,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor.withOpacity(.2),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Text(title,
                  style: font.copyWith(fontSize: 17.0,color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
