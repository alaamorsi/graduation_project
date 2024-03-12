import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/instructor/home/instructor_home.dart';
import '../../../modules/instructor/course/instructor_courses.dart';
import '../../../modules/instructor/profile/instructor_profile.dart';
import 'instructor_states.dart';

class InstructorCubit extends Cubit<InstructorStates> {
  InstructorCubit() : super(InstructorInitialStates());

  static InstructorCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const TeacherHomeScreen(),
    const TeacherCoursesScreen(),
    const TeacherProfile(),

  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(InstructorChangeBottomNavState());
  }

  List<bool> courseTypeSel=[false,false];
  void changeCourseTypeSelection(int sel) {
    switch (sel) {
      case 0:
        courseTypeSel[0]= !courseTypeSel[0];
        courseTypeSel[1]= false;
        break;
      case 1:
        courseTypeSel[0]= false;
        courseTypeSel[1]= !courseTypeSel[1];
        break;
    }
    emit(ChangeCourseTypeSelectionState());
  }

  String newCourseSub='';
  String newCourseEduLevel='';
  int newCourseTerm=0;
  void addNewCourseSelection(var v,var subSel) {
    v = subSel;
    emit(AddNewCourseSelectionState());
  }

}