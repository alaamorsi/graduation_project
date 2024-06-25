import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/network/cache_helper.dart';

class LiveScreen extends StatefulWidget {
  final CourseModel course;
  const LiveScreen({super.key, required this.course});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController liveController = TextEditingController();
    //Get.to(() =>launchUrl(Uri.parse('https://digitutors.runasp.net/MakeRoom.html?courseid=${course.courseId}&id=${CacheHelper.getData(key: 'id')}&username=${CacheHelper.getData(key: 'userName')}')));
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Prepare for ',style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold),),
                Text('Live',style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,color: Colors.red),),
              ],
            ),
            SizedBox(height: 20.0,),
            defaultFormField(
                context: context,
                controller: liveController,
                type: TextInputType.text,
                validate: (String? value) {
                  return '';
                },
                label: 'Live Url'),
            SizedBox(
              height: 20.0,
            ),
            usedButton(
              onPressed: ()async{
                await launchUrl(Uri.parse('${liveController.text}&courseid=${widget.course.courseId}&id=${CacheHelper.getData(key: 'id')}&username=${CacheHelper.getData(key: 'userName')}'));
              },
                atEnd: false,
                text: 'Go to Live',
                color: Theme.of(context).primaryColor,
                context: context),
          ],
        ),
      ),
    );
  }
}
