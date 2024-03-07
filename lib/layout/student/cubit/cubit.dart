import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/search/search_screen.dart';
import 'package:graduation_project/modules/student/discovery/home_screen.dart';
import 'package:graduation_project/modules/student/profile/profile.dart';
import '../../../modules/student/my_courses/reserved_screen.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentInitialStates());

  static StudentCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ReservedScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = [
    'discovery',
    'my courses',
    'notifications',
    'profile'
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

  bool startSearching = false;
  void showSearchFilter(context) async
  {
    final List<String> results = await showModalBottomSheet(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (BuildContext context){
          return const MultiSelect();
        }
    );
    emit(StartSearchState());
    print(results);
  }
}