import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../../shared/component/components.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});
//ناقص الفانكشن الي بيتجيت الassignment
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:secondAppbar(context: context, title: "Assignment".tr),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Assignment 1",
                  style: font.copyWith(
                    color: Theme.of(context).cardColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                const Spacer(),
                Text(
                  "23 November 11.59pm",
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
              "In legal terms, an assignment refers to the transfer of a right or liability from one party to another. It can involve property, financial agreements, or other legal matters",
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: font.copyWith(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('Assets/fading.jpg'), fit: BoxFit.cover),
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
              onPressed: () {

              },
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
                showToast(title: "Submitted", description: "assignment has been submitted", state: MotionState.success, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
