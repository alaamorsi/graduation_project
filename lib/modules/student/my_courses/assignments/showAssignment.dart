import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/modules/student/my_courses/assignments/assignment_webview_screen.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../shared/component/components.dart';

class ShowAssignmentScreen extends StatelessWidget {
  final AssignmentModel assignment;
  final int index;

  const ShowAssignmentScreen(
      {super.key, required this.assignment, required this.index});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(context: context, title: "Assignment".tr),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Assignment $index",
                  style: font.copyWith(
                    color: Theme.of(context).cardColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${assignment.deadLine.split('T')[0]} ${assignment.deadLine.split('T')[1].split('.')[0]}',
                  style: font.copyWith(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              assignment.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: font.copyWith(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: InkWell(
                    onTap: (){
                      String url = assignment.file.substring(8);
                      url = 'https://digitutors.runasp.net/$url';
                      print(url);
                      Get.to(()=>ShowFile(url: url));
                    },
                    child: Image(
                        image: AssetImage('Assets/fading.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const Spacer(),
            usedButton(
              paddingSize: 10,
              radius: 5,
              atEnd: false,
              text: 'Add work',
              color: Theme.of(context).cardColor,
              context: context,
              onPressed: () {},
            ),
            const SizedBox(height: 15.0),
            usedButton(
              paddingSize: 10,
              radius: 5,
              atEnd: false,
              text: 'submit',
              color: Colors.black38,
              context: context,
              onPressed: () {
                showToast(
                    title: "Submitted",
                    description: "assignment has been submitted",
                    state: MotionState.success,
                    context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
