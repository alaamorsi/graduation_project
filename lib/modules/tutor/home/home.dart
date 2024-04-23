import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:hexcolor/hexcolor.dart';
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
    var color = theme.primaryColor;
    String firstName = CacheHelper.getData(key: 'firstName').toString();
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title:
                    'Hello,Mr ${firstName.replaceRange(0, 1, firstName[0].toUpperCase())}',
                ),
            body: Container(
              child: Column(
                children: [
                  newDivider(),
                  Text('Your work',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        width: screenWidth,
                        height: screenHeight/7,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(.1),
                          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              //Teacher image
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Container(
                                  width: screenHeight/10,
                                  height: screenHeight/10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image:  AssetImage('Assets/profile/man_1.png'),
                                      fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Arabic Complete Course',
                                      style: font.copyWith(fontSize: 16.0,color: color),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    child: Text(
                                      '120 ${'lessons'.tr}',
                                      style: font.copyWith(fontSize: 12.0,color: Colors.black.withOpacity(.5)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star_rate_rounded,
                                          size: 20.0,
                                          color: HexColor("FDBD01"),
                                        ),
                                        Text('5',
                                          style: font.copyWith(fontSize: 12.0,color: Colors.black.withOpacity(.5)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                        onPressed: (){},
                                        icon: false?  Icon(Icons.favorite,color: color,) : Icon(Icons.favorite_border,color: color,)
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${'EGP'.tr}${120}',
                                      style: font.copyWith(fontSize: 14.0,color: color),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(onPressed: (){
                          Get.to(AddCourse());
                        },child: Icon(Icons.add),tooltip: 'Create a new course',),
                      ],
                    ),
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
// Padding(
// padding: const EdgeInsets.all(17),
// child: Wrap(
// children: [
// dashboardItem(
// context: context,
// title: "Add Course",
// image: "Assets/for_teacher/addVideo.png",
// goTo: () {
// navigateTo(context, const AddCourse());
// },
// ),
// dashboardItem(
// context: context,
// title: "Courses",
// image: "Assets/for_teacher/course.png",
// goTo: () {},
// ),
// dashboardItem(
// context: context,
// title: "Notes",
// image: "Assets/for_teacher/notes.png",
// goTo: () {},
// ),
// dashboardItem(
// context: context,
// title: "Subscriptions",
// image: "Assets/for_teacher/getMoney.png",
// goTo: () {},
// ),
// dashboardItem(
// context: context,
// title: "One Touch",
// image: "Assets/for_teacher/oneTouch.png",
// goTo: () {},
// ),
// dashboardItem(
// context: context,
// title: "Gifts",
// image: "Assets/for_teacher/gifts.png",
// goTo: () {},
// ),
// ],
// ),
// ),