import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import 'add_videos.dart';

class TutorCoursesScreen extends StatelessWidget {
  const TutorCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondAppbar(
        context: context,
        title:"Class",
      ),
      body: Padding(padding: const EdgeInsets.all(20),
        child: Wrap(
          children: [
          dashboardItem(
            context: context,
            title: "Add Video",
            image: "Assets/for_teacher/addVideo.png",
            goTo: () {
              navigateTo(context, const AddVideos());
            },
          ),
          dashboardItem(
            context: context,
            title: "Students",
            image: "Assets/for_teacher/notes.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Exams",
            image: "Assets/for_teacher/getMoney.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Assignments",
            image: "Assets/for_teacher/oneTouch.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Attachment",
            image: "Assets/for_teacher/gifts.png",
            goTo: () {},
          ),
            dashboardItem(
              context: context,
              title: "Chat",
              image: "Assets/for_teacher/communications.png",
              goTo: () {},
            ),
        ],
        ),
      ),
    );
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
}
