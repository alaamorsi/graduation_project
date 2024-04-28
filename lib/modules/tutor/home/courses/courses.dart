import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import 'add_videos.dart';
import 'chat.dart';

class TutorCoursesScreen extends StatelessWidget {
  final String subject;
  const TutorCoursesScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondAppbar(
        context: context,
        title:subject.tr,
      ),
      body: Padding(padding: const EdgeInsets.all(20),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
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
            image: "Assets/for_teacher/students.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Exams",
            image: "Assets/for_teacher/exam.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Assignments",
            image: "Assets/for_teacher/exam.png",
            goTo: () {},
          ),
          dashboardItem(
            context: context,
            title: "Attachment",
            image: "Assets/for_teacher/attach.png",
            goTo: () {},
          ),
            dashboardItem(
              context: context,
              title: "Chat",
              image: "Assets/for_teacher/chat.png",
              goTo: () {
                navigateTo(context, const ChatScreen());
              },
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
      child: Container(
        padding: const EdgeInsets.all(11.0),
        margin:const EdgeInsets.all(11.0),
        height: 150,
        width: screenWidth/ 2-50,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).cardColor,
                  blurRadius: .9,
                  spreadRadius: .6),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: font.copyWith(fontSize: 17.0, color: Theme.of(context).primaryColor),),
            Expanded(
              child: CircleAvatar(
                  child: Image(image: AssetImage(image))),
            ),
          ],
        ),
      ),
    );
  }
}
//          Column(
//             children: [
//               Container(
//                   width: screenWidth / 2.6,
//                   padding: const EdgeInsets.only(
//                       left: 30, right: 30, top: 20, bottom: 15),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image(image: AssetImage(image))),
//               Container(
//                 width: screenWidth / 2.6,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).canvasColor.withOpacity(.2),
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Center(
//                   child: Text(
//                     title,
//                     style: font.copyWith(
//                         fontSize: 17.0, color: Theme.of(context).primaryColor),
//                   ),
//                 ),
//               ),
//             ],
//           ),