import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/instructor/home/add_course.dart';
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
            ),
            title: Text('Hello,Mr ${CacheHelper.getData(key: 'firstName')}!',
              style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              children: [
                dashboardItem(
                    context: context,
                    title: "New Course!",
                    icon: Icons.assistant,
                    cardColor: Colors.orangeAccent,
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                ),
                dashboardItem(
                    context: context,
                    title: "Nothing",
                    icon: Icons.video_collection,
                    cardColor: Colors.greenAccent,
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                ),
                dashboardItem(
                    context: context,
                    title: "Nothing",
                    icon: Icons.assessment,
                    cardColor: Colors.blueAccent,
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                ),
                dashboardItem(
                    context: context,
                    title: "Nothing",
                    icon: Icons.numbers,
                    cardColor: Colors.purpleAccent,
                    goTo: (){
                      navigateTo(context, const AddCourse());
                    },
                ),
              ],
            ),
          )
        );
      }
    );
  }
}

Widget dashboardItem({
  required BuildContext context,
  required String title,
  required IconData icon,
  required Color cardColor,
  required void Function()  goTo,
}) {
  return InkWell(
    onTap:goTo,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(21.0)),
          boxShadow: [
            BoxShadow(
              color:Theme.of(context).primaryColorDark.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(-3, 4)
            )],
          // color: cardColor,
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle
              ),
                child: Icon(icon,size: 35,color: Theme.of(context).primaryColorLight,)
            ),
            const SizedBox(height: 9,),
            Text(title,
              style: font.copyWith(fontSize: 17.0,color: Theme.of(context).primaryColorDark),
            ),
          ],
        ),
      ),
    ),
  );
}
