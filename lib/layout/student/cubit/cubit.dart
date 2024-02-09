import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';

import '../../../shared/constant.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentInitialStates());

  static StudentCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  String logoImage = mode?"Assets/logo1.png":"Assets/logo2.png";
  List<Widget> screens = [
  ];
  List<String> titles = [
    'استكشاف',
    'كورساتي',
    'البروفايل'
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(StudentChangeBottomNavState());

  }
}