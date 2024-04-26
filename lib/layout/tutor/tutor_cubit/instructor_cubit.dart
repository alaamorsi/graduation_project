import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/student/payMob_manager/payMob_manager.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../modules/tutor/home/home.dart';
import '../../../modules/tutor/notification/notification.dart';
import '../../../modules/tutor/profile/profile.dart';
import 'instructor_states.dart';

class InstructorCubit extends Cubit<InstructorStates> {
  InstructorCubit() : super(InstructorInitialStates());

  static InstructorCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const TutorHomeScreen(),
    const TutorNotifications(),
    const TutorProfile(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(InstructorChangeBottomNavState());
  }

  List<bool> courseTypeSel = [false, false];

  void changeCourseTypeSelection(int sel) {
    switch (sel) {
      case 0:
        courseTypeSel[0] = !courseTypeSel[0];
        courseTypeSel[1] = false;
        break;
      case 1:
        courseTypeSel[0] = false;
        courseTypeSel[1] = !courseTypeSel[1];
        break;
    }
    emit(ChangeCourseTypeSelectionState());
  }

  String newCourseSub = '';
  String newCourseEduLevel = '';
  int newCourseTerm = 0;
  String newCourseStage = '';

  void addNewCourseSelection(var v, var subSel) {
    v = subSel;
    emit(AddNewCourseSelectionState());
  }

  String firstName = CacheHelper.getData(key: 'firstName');
  String lastName = CacheHelper.getData(key: 'lastName');
  String bio = CacheHelper.getData(key: 'biography') ?? "";
  ImageProvider<Object> imageProvider =
      const AssetImage("Assets/profile/man_1.png");

  void getImage() {
    if (CacheHelper.getData(key: 'profileStr') != null) {
      Uint8List picture = base64Decode(CacheHelper.getData(key: 'profileStr'));
      imageProvider = MemoryImage(picture);
    } else {
      imageProvider = const AssetImage("Assets/profile/man_1.png");
    }
    emit(HasImageState());
  }

  void getData() {
    firstName = CacheHelper.getData(key: 'firstName');
    lastName = CacheHelper.getData(key: 'lastName');
    bio = CacheHelper.getData(key: 'biography') ?? "";
    emit(GetUserDataSuccessState());
  }

  void clearCache() async {
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
      emit(ProfileImagePickedErrorState());
    }
  }

  List<File?> videos = [];
  File? video;

  Future<void> pikeVideoFromGallery() async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      videos.add(video);
      emit(VideoPickedSuccessState());
    } else {
      emit(VideoPickedErrorState());
    }
  }

  Future<void> pikeVideoFromCamera() async {
    final pickedVideo = await picker.pickVideo(source: ImageSource.camera);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      videos.add(video);
      emit(VideoPickedSuccessState());
    } else {
      emit(VideoPickedErrorState());
    }
  }

  //update User image
  Future<int?> updateUserProfileImage({
    required File? imageFile,
  }) async {
    emit(UpdateProfileImageLoadingState());
    FormData formData = FormData();
    if (imageFile != null) {
      formData = FormData.fromMap({
        'newPicture': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
    }
    try {
      Response response = await DioHelper.updateImage(
        url: updateImage,
        data: formData,
      );
      emit(UpdateProfileImageSuccessState());
      return response.statusCode;
    } catch (error) {
      if (error is DioException) {
        emit(UpdateProfileImageErrorState());
        return error.response!.statusCode;
      }
    }
    return null;
  }

  //update User Data
  Future<int?> updateUserData({
    required bool updateFirstName,
    required bool updateLastName,
    required bool updateBio,
    String? newFirstName,
    String? newLastName,
    String? newBio,
  }) async {
    emit(UpdateUserDataLoadingState());
    List<Map<String, dynamic>> updateData =
        List<Map<String, dynamic>>.empty(growable: true);
    if (updateFirstName) {
      updateData.add({
        'path': 'firstName',
        'op': 'replace',
        'value': newFirstName,
      });
    }
    if (updateLastName) {
      updateData.add({
        'path': 'lastName',
        'op': 'replace',
        'value': newLastName,
      });
    }
    if (updateBio) {
      updateData.add({
        'path': 'biography',
        'op': 'replace',
        'value': newBio,
      });
    }
    try {
      Response response =
          await DioHelper.patchData(url: updateDataPatch, data: updateData);
      if (updateFirstName) {
        emit(UpdateFirstNameSuccessState());
      }
      if (updateLastName) {
        emit(UpdateLastNameSuccessState());
      }
      if (updateBio) {
        emit(UpdateBioSuccessState());
      }
      return response.statusCode;
    } catch (error) {
      if (error is DioException) {
        emit(UpdateUserDataErrorState());
        return error.response!.statusCode;
      }
    }
    return 0;
  }

  bool back = true;

  void isBack() {
    back = false;
    emit(EnableButtonBackState());
  }

  Future<void> payManager(int coursePrice,String nameSubject , String price , String description ) async{
    emit(PaymentManagerLoadingState());
    PaymobManager().getPaymentKey(
        coursePrice,"EGP",nameSubject,price,description,
    ).then((String paymentKey) {
      launchUrl(
        Uri.parse("https://accept.paymob.com/api/acceptance/iframes/830423?payment_token=$paymentKey"),
      );
      emit(PaymentManagerSuccessState());
    }).catchError((error){
      emit(PaymentManagerErrorState(error));
    });
  }

  Future<int?> logOut (String refreshToken) async{
    try{
      Response response = await DioHelper.delete(
        url: logout,
        token: refreshToken,
      );
      emit(LogOutSuccessState());
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
      return response.statusCode;
    }catch(error){
      if(error is DioException){
        emit(LogOutErrorState());
        return error.response!.statusCode;
      }
    }
    return null;
  }


}
