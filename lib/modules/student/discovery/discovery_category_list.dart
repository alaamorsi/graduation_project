import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar: secondAppbar(context: context, title: "Special".tr),
          body:  ListView(
            shrinkWrap: true,
            children: [
              slideItem(context: context, title: "Science is Amazing".tr, id: 1, image: "Assets/subjects_icon/science.png"),
              slideItem(context: context, title: "Learn English Easy".tr, id: 2, image: "Assets/subjects_icon/alphabet.png"),
              slideItem(context: context, title: "Know more about History".tr, id: 1, image: "Assets/subjects_icon/history.png"),
              slideItem(context: context, title: "Atoms is too Tiny".tr, id: 2, image: "Assets/subjects_icon/atom.png"),
              slideItem(context: context, title: "Is that A Ball !!!".tr, id: 1, image: "Assets/subjects_icon/ball.png"),
              slideItem(context: context, title: "It's look like a Cube".tr, id: 2, image: "Assets/subjects_icon/block.png"),
              slideItem(context: context, title: "DNA what it Mean !".tr, id: 1, image: "Assets/subjects_icon/dna.png"),
              slideItem(context: context, title: "Geology is Funny now".tr, id: 2, image: "Assets/subjects_icon/globe.png"),
              slideItem(context: context, title: "Find Great Idea !".tr, id: 1, image: "Assets/subjects_icon/idea.png"),
              slideItem(context: context, title: "Math is not that hard".tr, id: 2, image: "Assets/subjects_icon/maths.png"),
              slideItem(context: context, title: "What is Solar System".tr, id: 1, image: "Assets/subjects_icon/solar-system.png"),
              slideItem(context: context, title: "Did you know it !!!".tr, id: 2, image: "Assets/subjects_icon/square-root.png"),
            ],
          ),
        );
      },
    );
  }
}
