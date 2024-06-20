import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class RateScreen extends StatefulWidget {
  final int courseId;
  const RateScreen({super.key, required this.courseId});

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  List<bool> stars =[false,false,false,false,false];
  var rate = 1.0;
  @override
  Widget build(BuildContext context) {
    TextEditingController rateController = TextEditingController();
    var cubit = StudentCubit.get(context);
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: secondAppbar(
        context: context,
        title: "reviewTheCourse".tr,
        hasAction: true,
        actionIcon: TextButton(onPressed: (){
          cubit.addRate(widget.courseId, rate, '');
        }, child: Text("publish".tr,style: font.copyWith(color: theme.primaryColor)))
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: cubit.imageProvider,radius: 25,),
                const Spacer(),
                Text(cubit.firstName,style: font.copyWith(fontSize: screenWidth*.07,color: theme.primaryColor),)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth*.06,vertical: screenHeight*.02),
              child: Row(
                children: [
                  starItem(theme: theme,index:0,lite: stars[0]),
                  starItem(theme: theme,index:1,lite: (stars[0]&&stars[1])),
                  starItem(theme: theme,index:2,lite: (stars[0]&&stars[1]&&stars[2])),
                  starItem(theme: theme,index:3,lite: (stars[0]&&stars[1]&&stars[2]&&stars[3])),
                  starItem(theme: theme,index:4,lite: (stars[0]&&stars[1]&&stars[2]&&stars[3]&&stars[4])),
                ],
            ),
            ),
            defaultFormField(
                context: context,
                controller: rateController,
                type: TextInputType.text,
                radius: 11,
                validate: (s){
                  return null;
                },
                label: "describeYourExperience(Optional)".tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget starItem({
    required ThemeData theme,
    required bool lite,
    required int index,
  }){
    return
      IconButton(
          onPressed:(){
            setState(() {
              for(int i=0;i<5;i++){
                if(i<=index){
                  stars[i]=true;
                }
                if(i>index){
                  stars[i]=false;
                }
              }
              rate = (index+1).toDouble();
            });
          },
          icon: lite?
            Icon(Icons.star_rate_rounded,color: theme.primaryColor,size: 35,):
            const Icon(Icons.star_border_rounded,color: Colors.grey,size: 35,)
      );
  }
}