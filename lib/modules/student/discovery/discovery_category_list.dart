import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
          appBar: secondAppbar(context: context, title: "New Courses"),
          body:  ListView(
            shrinkWrap: true,
            children: [
              slideItem(context: context, title: "Science is Amazing", id: 1, image: "Assets/subjects_icon/science.png"),
              slideItem(context: context, title: "Learn English Easy", id: 2, image: "Assets/subjects_icon/alphabet.png"),
              slideItem(context: context, title: "Know more about History", id: 1, image: "Assets/subjects_icon/history.png"),
              slideItem(context: context, title: "Atoms is too Tiny", id: 2, image: "Assets/subjects_icon/atom.png"),
              slideItem(context: context, title: "Is that A Ball !!!", id: 1, image: "Assets/subjects_icon/ball.png"),
              slideItem(context: context, title: "It's look like a Cube", id: 2, image: "Assets/subjects_icon/block.png"),
              slideItem(context: context, title: "Dna what it Mean !", id: 1, image: "Assets/subjects_icon/dna.png"),
              slideItem(context: context, title: "Geology is Funny now", id: 2, image: "Assets/subjects_icon/globe.png"),
              slideItem(context: context, title: "Find Great Idea !", id: 1, image: "Assets/subjects_icon/idea.png"),
              slideItem(context: context, title: "Math is not that hard", id: 2, image: "Assets/subjects_icon/maths.png"),
              slideItem(context: context, title: "What is Solar System", id: 1, image: "Assets/subjects_icon/solar-system.png"),
              slideItem(context: context, title: "Did you know it !!!", id: 2, image: "Assets/subjects_icon/square-root.png"),
            ],
          ),
        );
      },
    );
  }
}
