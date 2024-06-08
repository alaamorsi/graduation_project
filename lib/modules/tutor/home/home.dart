import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/tutor/home/courses/courses.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import 'add_course/select_course_type.dart';

class TutorHomeScreen extends StatelessWidget {
  const TutorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Your courses'.tr,
            hasActions: false,
          ),
          body: ListView(
            children: [
              newDivider(),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Wrap(
                  children: [
                    courseDesign(theme: theme, subject: "Arabic", subscriptions: 20, rate: 0),
                    courseDesign(theme: theme, subject: "English", subscriptions: 1, rate: 4),
                    courseDesign(theme: theme, subject: "Maths", subscriptions: 2, rate: 3),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: (){
                    Get.to(()=>const SelectCourseType());
                  },
                  backgroundColor: theme.primaryColor,
                  tooltip: 'Create a new course',
                  child: const Icon(Icons.add,color: Colors.white,),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
  Widget courseDesign({
    required ThemeData theme,
    required String subject,
    required int subscriptions,
    required int rate,
}){
    return InkWell(
      onTap: (){
        Get.to(TutorCoursesScreen(subject: subject,));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child:Container(
          width: screenWidth,
          height: screenHeight/5,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(.4),
            borderRadius: const BorderRadius.all(Radius.circular(20.0),),
          ),
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                //image
                Container(
                  width: screenHeight/9,
                  height: screenHeight/9,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('Assets/subjects_icon/$subject.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                  ),
                ),
                const SizedBox(width: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        subject.tr,
                        style: font.copyWith(fontSize: 23.0,color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.star_rate_rounded,color: rate>0?HexColor("FDBD01"):Colors.white,size: 30,),
                          Text(rate>0?'$rate':'--',
                            style: font.copyWith(fontSize: 20.0,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          subscriptions>1? const Icon(Icons.groups,color:Colors.white,size: 30,): const Icon(Icons.person,color:Colors.white,size: 27,),
                          const SizedBox(width: 5,),
                          Text('$subscriptions ${'subscriber'.tr}',
                            style: font.copyWith(fontSize: 18.0,color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}