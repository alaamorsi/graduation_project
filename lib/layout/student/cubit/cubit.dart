import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/profile.dart';
import 'package:graduation_project/modules/student/student_discovery.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentInitialStates());

  static StudentCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const StudentDiscovery(),
    const ProfileScreen(),
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
  bool isPaid = false ;
  List<bool> demoList = List<bool>.filled(100, false);
  void checkViewDemoList(index)
  {
    demoList[index] = !demoList[index];
    emit(CheckViewDemoListState());
  }
  void checkPayment()
  {
    isPaid = !isPaid;
    emit(CheckPaymentState());
  }
  bool isFavorite = false;
  void checkFavorite()
  {
    isFavorite =!isFavorite;
    emit(CheckFavoriteState());
  }
}