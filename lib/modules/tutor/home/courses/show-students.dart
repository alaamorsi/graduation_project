import 'dart:convert';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../../shared/component/constant.dart';

class ShowStudents extends StatelessWidget {
  final int courseId;
  const ShowStudents({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    InstructorCubit.get(context).getLessons();
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
        var cubit = InstructorCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Students",
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth *.02),
            child: ConditionalBuilder(
              condition: true,
              builder: (context) {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index)=>studentCard(color: theme.cardColor, studentName: 'sameh Ahmed', studentImage: ''),
                  itemCount: 3,
                );
              },
              fallback: (context){
                if(state is GetInstCourseLessonsErrorState){
                  return Center(
                    child: Text(
                      "You don't have any students yet",
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),
                  );
                }
                else{
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        color: theme.primaryColor,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
  Widget studentCard({
    required String studentName,
    required String studentImage,
    required Color color,
  }){
    ImageProvider<Object> image = const AssetImage("Assets/profile/man_1.png");
    if (studentImage !='') {
      Uint8List picture = base64Decode(studentImage);
      image = MemoryImage(picture);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal:screenWidth * 0.03,vertical: screenHeight * 0.015),
      margin: EdgeInsets.all(screenWidth * 0.02),
      width: screenWidth,
      height: screenHeight * 0.11,
      decoration: BoxDecoration(
        color: color.withOpacity(.7),
        borderRadius: const BorderRadius.all(
          Radius.circular(23.0),
        ),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          const Icon(Icons.clear_outlined,color: Colors.white,),
          Row(
            children: [
              //Student image
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: screenWidth*.083,
                child: CircleAvatar(
                  backgroundImage: image,
                  radius: screenWidth*.082,
                ),
              ),
              SizedBox(width: screenWidth*.02,),
              Text(
                studentName,
                style: font.copyWith(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
