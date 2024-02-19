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

  List<bool> isPaid = [] ;
  List<bool> demoList = List<bool>.filled(30, false);
  void checkViewDemoList(index)
  {
    demoList[index] = !demoList[index];
    emit(CheckViewDemoListState());
  }

  void fullPaidList(int n)
  {
    isPaid = List<bool>.filled(n, false);
    isPaid[0]=true;
    emit(CheckPaymentState());
  }

  void checkPayment(int n)
  {
    for(int i=1;i<n;i++){
      isPaid[i] =! isPaid[i];
    }
    emit(CheckPaymentState());
  }

  bool isFavorite = false;
  void checkFavorite()
  {
    isFavorite =!isFavorite;
    emit(CheckFavoriteState());
  }
}