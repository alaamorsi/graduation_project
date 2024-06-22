import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/modules/show_file.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../shared/component/constant.dart';

class ShowAssignmentSolutionScreen extends StatelessWidget{
  final AssignmentModel assignment;
  const ShowAssignmentSolutionScreen({super.key,required this.assignment});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit,InstructorStates>(
        listener: (context,state) {},
        builder:(context,state){
          var cubit = InstructorCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "Assignment Solutions".tr),
            body: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: ConditionalBuilder(
                condition: state is InstGetAssignmentsSuccessState || cubit.assignmentSolutions.isNotEmpty,
                builder: (BuildContext context) {
                  return cubit.assignmentSolutions.isNotEmpty?
                  ListView.builder(
                  itemBuilder: (BuildContext context, int index)=> solutionItem(solution: cubit.assignmentSolutions[index],theme: theme),
                  itemCount: cubit.assignmentSolutions.length) :
                  Center(
                    child: Text("There are not Solutions yet".tr,
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),
                  );
                },
                fallback: (BuildContext context) =>
                    ConditionalBuilder(
                      condition:state is InstGetAssignmentsErrorState && cubit.assignmentSolutions.isEmpty,
                      builder: (BuildContext context)=> Center(child: Text("There are not Solutions yet".tr,
                        style: font.copyWith(
                            color: theme.primaryColor,
                            fontSize: screenWidth * 0.06),
                        ),
                      ),
                      fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,),
                      ),
                    ),
              ),
            ),
          );
        }
    );
  }

  Widget solutionItem({
    required SolutionModel solution,
    required ThemeData theme,
  })
  {
    String extension = solution.solutionUrl.split('.')[1];
    return InkWell(
      onTap: (){
      },
      child: Container(
        margin: EdgeInsets.all(screenWidth*.02),
        padding: EdgeInsets.all(screenWidth*.03),
        width: screenWidth,
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.person,size: screenWidth*.08,),
                    SizedBox(width: screenWidth*.02,),
                    SizedBox(
                      width: screenWidth*.5,
                      child: Text(solution.fullName,
                        overflow: TextOverflow.ellipsis,
                        style: font.copyWith(fontSize: 23.0,color: theme.primaryColorDark),
                      ),
                    ),
                    SizedBox(width: screenWidth*.1,),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: Text("${solution.studentId}/${assignment.grade}"),
                    ),
                  ]
                ),
                Container(
                  margin: EdgeInsets.all(screenWidth*.02),
                  width: screenWidth*.8,
                  height: 0.5,
                  color: Colors.grey,
                ),
                const SizedBox(height: 5,),
                Text(solution.description,
                  style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        String url = solution.solutionUrl.substring(8);
                        url = 'https://digitutors.runasp.net/$url';
                        Get.to(() => ShowFile(url: url));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.attachment_outlined,size: 25,color: Colors.black38,),
                          const SizedBox(width: 5,),
                          Center(child: Text("Solution.$extension",style: font.copyWith(fontSize: 18,color: Colors.black38),)),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth*.27,),
                    Text("AddGrade",style: font.copyWith(fontSize: 18,color: theme.primaryColor),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
