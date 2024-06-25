import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import 'add_course1.dart';

class SelectCourseType extends StatefulWidget {
  const SelectCourseType({super.key});

  @override
  SecondScreenState createState() => SecondScreenState();

}
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class SecondScreenState extends State<SelectCourseType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: secondAppbar(
        context: context,
        title: "Course Type?".tr,
        hasAction: false,
      ),
      body:Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    Get.to(const AddCourse(courseType: 'Recorded',));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(39),
                        height: screenWidth/1.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Image(image: AssetImage("Assets/for_teacher/recorded.png")),
                      ),
                      const SizedBox(height: 10.0),
                      Text("Recorded lessons".tr,style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                    ],
                  ),
                ),
                newDivider(),
                InkWell(
                  onTap: () {
                    Get.to(()=>const AddCourse(courseType: 'Live',));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(39),
                        height: screenWidth/1.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Image(image: AssetImage("Assets/for_teacher/live.png")),
                      ),
                      const SizedBox(height: 10.0),
                      Text("Live lessons".tr,style: font.copyWith(color: Theme.of(context).primaryColor,fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}