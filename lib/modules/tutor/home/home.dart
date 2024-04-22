import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/network/cache_helper.dart';
import 'add_course1.dart';
import 'notification.dart';

class TutorHomeScreen extends StatelessWidget {
  const TutorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    String firstName = CacheHelper.getData(key: 'firstName').toString();
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title:
                    'Hello,Mr ${firstName.replaceRange(0, 1, firstName[0].toUpperCase())}',
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: IconButton(
                        onPressed: () {
                          navigateTo(context, const TutorNotifications());
                        },
                        icon: Icon(
                          Icons.notifications,
                          size: 25,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ]),
            body: Padding(
              padding: const EdgeInsets.all(17),
              child: Wrap(
                children: [
                  dashboardItem(
                    context: context,
                    title: "Add Course",
                    image: "Assets/for_teacher/addVideo.png",
                    goTo: () {
                      navigateTo(context, const AddCourse());
                    },
                  ),
                  dashboardItem(
                    context: context,
                    title: "Courses",
                    image: "Assets/for_teacher/course.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Notes",
                    image: "Assets/for_teacher/notes.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Subscriptions",
                    image: "Assets/for_teacher/getMoney.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "One Touch",
                    image: "Assets/for_teacher/oneTouch.png",
                    goTo: () {},
                  ),
                  dashboardItem(
                    context: context,
                    title: "Gifts",
                    image: "Assets/for_teacher/gifts.png",
                    goTo: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget dashboardItem({
  required BuildContext context,
  required String title,
  required String image,
  required void Function() goTo,
}) {
  return InkWell(
    onTap: goTo,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).cardColor,
                  blurRadius: .9,
                  spreadRadius: .6),
            ]),
        child: Column(
          children: [
            Container(
                width: screenWidth / 2.6,
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 15),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image(image: AssetImage(image))),
            Container(
              width: screenWidth / 2.6,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  title,
                  style: font.copyWith(
                      fontSize: 17.0, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
