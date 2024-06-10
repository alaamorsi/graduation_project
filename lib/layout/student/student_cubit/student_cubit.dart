import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/notification/notification.dart';
import 'package:graduation_project/modules/student/payMob_manager/payMob_manager.dart';
import 'package:graduation_project/modules/student/discovery/search_screen.dart';
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
    const NotificationsScreen(),
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
    await showAdaptiveDialog(
        context: context,
        builder: (BuildContext context){
          return const MultiSelect();
        }
    );
    emit(StartSearchState());
  }

  Future getCourses(int pageNumber) async{
        try{
          Response response = await sendRequest(method: 'get', url: getCoursesEndPoint);
          print('###################################################');
          print(response);
          final List decodedData = json.decode(response.data);
          decodedData.map((movie) => CourseModel.fromJson(movie)).toList();
          allCourse = decodedData as Future<List<CourseModel>>?;
          emit(StudentGetCoursesSuccessState());
        }
        catch(e){
          print('Nullllllllllllllllllllllllllllllllllllllll');
          print(e);
        }
    }


  Future<void> payManager(int coursePrice,String description) async{
    emit(PaymentManagerLoadingState());
    PaymobManager().getPaymentKey(
        coursePrice,"EGP",description,
    ).then((String paymentKey) {
      launchUrl(
        Uri.parse("https://accept.paymob.com/api/acceptance/iframes/830423?payment_token=$paymentKey"),
      );
      emit(PaymentManagerSuccessState());
    }).catchError((error){
      emit(PaymentManagerErrorState(error));
    });
  }

  //student data
  String firstName=CacheHelper.getData(key: 'firstName');
  String lastName=CacheHelper.getData(key: 'lastName');
  String userName=CacheHelper.getData(key: 'userName');
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
    firstName=CacheHelper.getData(key: 'firstName')??'';
    lastName=CacheHelper.getData(key: 'lastName')??'';
    userName=CacheHelper.getData(key: 'userName');
    bio=CacheHelper.getData(key: 'biography')??"";
    emit(GetUserDataSuccessState());
  }


  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());
    }
  }

  //update User image
  Future<int?> updateUserProfileImage({
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
    try{
      Response response = await sendRequest(
          method: 'updateImage', url: updateImage, formData: formData);
      emit(UpdateProfileImageSuccessState());
      return response.statusCode;
    }catch(error){
      if (error == 401) {
        emit(SessionEndedState());
      } else if (error is DioException) {
        emit(UpdateProfileImageErrorState());
        return error.response!.statusCode;
      }
    }
    return null;
  }

  //update User Data
  Future<int?> updateUserData({
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
    try{
      Response response =
      await sendRequest(
          method: 'patch', url: updateDataPatch, listMap: updateData);
      if(updateFirstName) {
        emit(UpdateFirstNameSuccessState());
      }
      if(updateLastName) {
        emit(UpdateLastNameSuccessState());
      }
      if(updateBio) {
        emit(UpdateBioSuccessState());
      }
      return response.statusCode;
    }catch(error){
      if (error == 401) {
        emit(SessionEndedState());
      } else if (error is DioException) {
        emit(UpdateUserDataErrorState());
      }
    }
    return 0;
  }

  Future<dynamic> sendRequest(
      {required String method,
        required String url,
        Map<String, String>? data,
        List<Map<String, dynamic>>? listMap,
        FormData? formData}) async {
    try {
      switch (method.toLowerCase()) {
        case 'get':
          return await DioHelper.getData(url: url,query: data!);
        case 'post':
          return await DioHelper.postData(url: url, data: data!);
        case 'put':
          return await DioHelper.putData(url: url, data: data!);
        case 'delete':
          return await DioHelper.delete(
            url: url, data: data,);
        case 'patch':
          return await DioHelper.patchData(url: url, data: listMap!);
        case 'updateimage':
          return await DioHelper.updateImage(url: url, data: formData);
        default:
          print('Method $method is not supported');
          throw UnsupportedError('Method $method is not supported');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 401) {
          try {
            var response = await DioHelper.postData(url: updateTokens, data: {
              'email': CacheHelper.getData(key: 'email'),
              'refreshToken': CacheHelper.getData(key: 'refreshToken')
            });
            CacheHelper.saveData(key: 'jwt', value: response.data['jwt']);
            CacheHelper.saveData(
                key: 'refreshToken', value: response.data['refreshToken']);
            return await sendRequest(
                method: method,
                url: url,
                data: data,
                listMap: listMap,
                formData: formData);
          } catch (e) {
            if (e is DioException) {
              if (e.response!.statusCode == 401) {
                throw 401;
              }
            }
          }
        } else {
          rethrow;
        }
      }
    }
  }

  Future<int?> logOut(String refreshToken) async {
    try {
      await sendRequest(method: 'delete', url: logout, data: {'refreshToken' : refreshToken});
      await clearCache();
      return 200;
    } catch (error) {
      if (error is int && error == 401) {
        await clearCache();
        return 200;
      } else {
        emit(SessionEndedState());
        return 404;
      }
    }
  }

  Future clearCache() async {
    currentIndex = 0;
    await CacheHelper.removeData(key: 'jwt');
    await CacheHelper.removeData(key: 'role');
    await CacheHelper.removeData(key: 'refreshToken');
    await CacheHelper.removeData(key: 'firstName');
    await CacheHelper.removeData(key: 'lastName');
    await CacheHelper.removeData(key: 'biography');
    await CacheHelper.removeData(key: 'email');
    await CacheHelper.removeData(key: 'profileStr');
    await CacheHelper.removeData(key: 'id');
    jwt = '';
    role = '';
    firstName = '';
    lastName = '';
    bio = '';
    imageProvider = const AssetImage("Assets/profile/man_1.png");
    emit(LogOutSuccessState());
  }
}