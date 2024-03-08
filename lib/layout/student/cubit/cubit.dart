import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/models/login_and_user_data_model.dart';
import 'package:graduation_project/modules/student/paymob_manager/paymob_manager.dart';
import 'package:graduation_project/modules/student/search/search_screen.dart';
import 'package:graduation_project/modules/student/discovery/home_screen.dart';
import 'package:graduation_project/modules/student/profile/profile.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
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

  List<Course> wishList=[];
  void addToWishList(Course course)
  {
    course.inFavourite = !course.inFavourite;
    if(course.inFavourite){
      wishList.add(course);
    }
    else if (!course.inFavourite){
      wishList.remove(course);
    }
    emit(CheckFavoriteState());
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
    final List<String> results = await showAdaptiveDialog(
        context: context,
        builder: (BuildContext context){
          return const MultiSelect();
        }
    );
    emit(StartSearchState());
    print(results);
  }
  Future<void> payManager(int coursePrice) async{
    emit(PaymentManagerLoadingState());
    PaymobManager().getPaymentKey(
        coursePrice,"EGP"
    ).then((String paymentKey) {
      launchUrl(
        Uri.parse("https://accept.paymob.com/api/acceptance/iframes/830423?payment_token=$paymentKey"),
      );
      emit(PaymentManagerSuccessState());
    }).catchError((error){
      emit(PaymentManagerErrorState(error));
      print(error.toString());
    });

  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }
// Get User Data
  LoginModel? model;
  void getUserData() {
    emit(GetUserDataLoadingState());

    emit(GetUserDataSuccessState());
  }


}