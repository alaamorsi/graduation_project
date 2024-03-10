import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/paymob_manager/paymob_manager.dart';
import 'package:graduation_project/modules/student/search/search_screen.dart';
import 'package:graduation_project/modules/student/discovery/home_screen.dart';
import 'package:graduation_project/modules/student/profile/profile.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';
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
    'Discovery',
    'My Enrolled Courses',
    'Search',
    'My Profile'
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

  //student data
  String firstName=CacheHelper.getData(key: 'firstName');
  String lastName=CacheHelper.getData(key: 'lastName');
  String bio=CacheHelper.getData(key: 'biography')??"";
   ImageProvider<Object> imageProvider=AssetImage("Assets/profile_icon_S.png");

  getImage(){
    Uint8List picture = base64Decode(CacheHelper.getData(key: 'profileStr'));
    imageProvider = MemoryImage(picture);
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

  //update User image
  FormData formData= FormData();
  Future<void> updateUserProfileImage({
    // required String name,
    required File? imageFile,
  }) async{
    emit(UpdateUserDataLoadingState());
    // formData.fields.addAll({
    //   'name':name,
    // } as Iterable<MapEntry<String, String>>);

    if(imageFile != null){
      formData.files.add(MapEntry(
        'profileImage',
        (await MultipartFile.fromFile(imageFile.path,
            filename: imageFile.path.split('/').last)),
      ));
    }
    DioHelper.updateImage(
        url: updateImage,
        data: formData.files.last.value
    ).then((value){
      print(value.statusCode);
      if(value.statusCode == 200)
      {
        emit(UpdateProfileImageSuccessState());

      }
    }).catchError((error){
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }

  //update User Data
  void updateUserData({
    required bool updateFirstName ,
    required bool updateLastName ,
    required bool updateBio ,
     String? newFirstName,
     String? newLastName,
     String? newBio,
  }) {
    emit(UpdateUserDataLoadingState());
    List<Map<String,dynamic>> updateData=  List<Map<String,dynamic>>.empty(growable: true);
    if(updateFirstName)
    {
      updateData.add({
        'path' : 'firstName',
        'op' : 'replace',
        'value' : newFirstName,
      });
    }
    if(updateLastName)
    {
      updateData.add({
        'path' : 'lastName',
        'op' : 'replace',
        'value' : newLastName,
      });
    }
    if(updateBio)
    {
      updateData.add({
        'path' : 'biography',
        'op' : 'replace',
        'value' : newBio,
      });
    }
    DioHelper.patchData(url: updateDataPatch, data: updateData).then((value){
      print(value.statusCode);
      if(value.statusCode == 200)
        {
          if(updateFirstName) {
            CacheHelper.saveData(key: 'firstName', value: newFirstName);
            firstName=newFirstName!;
            emit(UpdateFirstNameSuccessState());
          }
          if(updateLastName) {
            CacheHelper.saveData(key: 'lastName', value: newLastName);
            lastName=newLastName!;
            emit(UpdateLastNameSuccessState());
          }
          if(updateBio) {
            CacheHelper.saveData(key: 'biography', value: newBio);
            bio=newBio!;
            emit(UpdateBioSuccessState());
          }
        }
    }).catchError((error){
      print(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }
}