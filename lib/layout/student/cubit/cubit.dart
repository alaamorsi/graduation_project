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
import '../../../shared/component/constant.dart';

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

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(StudentChangeBottomNavState());
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
  ImageProvider<Object> imageProvider=const AssetImage("Assets/profile/man_1.png");

  void getImage(){
    if(CacheHelper.getData(key: 'profileStr')!=null){
      Uint8List picture = base64Decode(CacheHelper.getData(key: 'profileStr'));
      imageProvider = MemoryImage(picture);
    }else{
      imageProvider = const AssetImage("Assets/profile/man_1.png");
    }
    emit(StudentHasImageState());
  }
  void getUser(){
    firstName=CacheHelper.getData(key: 'firstName');
    lastName=CacheHelper.getData(key: 'lastName');
    bio=CacheHelper.getData(key: 'biography')??"";
    emit(GetUserDataSuccessState());
  }

  void clearCache() async{
    await CacheHelper.removeData(key: 'jwt');
    await CacheHelper.removeData(key: 'role');
    await CacheHelper.removeData(key: 'firstName');
    await CacheHelper.removeData(key: 'lastName');
    await CacheHelper.removeData(key: 'biography');
    await CacheHelper.removeData(key: 'email');
    await CacheHelper.removeData(key: 'profileStr');
    jwt = 'null';
    role = 'null';
    firstName = '';
    lastName = '';
    bio = '';
    imageProvider = const AssetImage("Assets/profile/man_1.png");
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
  Future<void> updateUserProfileImage({
    required File? imageFile,
  }) async{
    emit(UpdateProfileImageLoadingState());
    FormData formData= FormData();
    if(imageFile != null){
      formData = FormData.fromMap({
        'newPicture':
        await MultipartFile.fromFile(imageFile.path, filename: imageFile.path.split('/').last,
        ),
      });
    }
    DioHelper.updateImage(
        url: updateImage,
        data: formData,
    ).then((value){
      if(value.statusCode == 200)
      {
        emit(UpdateProfileImageSuccessState());
        print("updateUserImage.statusCode =${value.statusCode}");
      }
    }).catchError((error){
      print("updateUserImage.statusCode =$error");
      emit(UpdateProfileImageErrorState());
    });
  }

  //update User Data
  Future<void> updateUserData({
    required bool updateFirstName ,
    required bool updateLastName ,
    required bool updateBio ,
    String? newFirstName,
    String? newLastName,
    String? newBio,
  }) async {
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
      print("updateUserData.statusCode =${value.statusCode}");
      if(value.statusCode == 200)
        {
          if(updateFirstName) {
            emit(UpdateFirstNameSuccessState());
          }
          if(updateLastName) {
            emit(UpdateLastNameSuccessState());
          }
          if(updateBio) {
            emit(UpdateBioSuccessState());
          }
          print("updateUserData.statusCode =${value.statusCode}");
        }
    }).catchError((error){
      print(error.toString());
      emit(UpdateUserDataErrorState(error.toString()));
    });
  }
}