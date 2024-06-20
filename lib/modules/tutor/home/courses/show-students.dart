import 'dart:convert';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/students_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../../shared/component/constant.dart';

class ShowStudents extends StatelessWidget {
  final int courseId;
  const ShowStudents({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
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
              condition: state is InstGetStudentsSuccessState ||cubit.students.isNotEmpty,
              builder: (BuildContext context) => ListView.builder(
                itemBuilder: (BuildContext context, int index)=> studentCard(color: theme.cardColor, student: cubit.students[index]),
                itemCount: cubit.students.length,),
              fallback: (BuildContext context) =>
                  ConditionalBuilder(
                    condition: state is InstGetStudentsErrorState && cubit.students.isEmpty,
                    builder: (BuildContext context)=> Center(child: Text("You don't have any students yet",
                      style: font.copyWith(
                          color: theme.primaryColor,
                          fontSize: screenWidth * 0.06),
                    ),),
                    fallback: (BuildContext context)=> Center(child: CircularProgressIndicator(color: theme.primaryColor,)),
                  ),
            ),
          ),
        );
      },
    );
  }
  Widget studentCard({
    required StudentModel student,
    required Color color,
  }){
    ImageProvider<Object> image = const AssetImage("Assets/profile/man_4.png");
    if (student.image !='') {
      Uint8List picture = base64Decode(student.image);
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
        alignment: isArabic?Alignment.topLeft:Alignment.topRight,
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
                student.name,
                style: font.copyWith(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
