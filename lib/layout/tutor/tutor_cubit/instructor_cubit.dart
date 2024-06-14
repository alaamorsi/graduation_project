import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/payMob_manager/payMob_manager.dart';
import 'package:graduation_project/modules/student/payMob_manager/web_view.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import '../../../modules/tutor/home/courses/courses.dart';
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

  String courseStage='PrimaryStage';
  late String courseSub;
  late String courseLevel;
  late String courseTerm;

  void subjectSelect(String s) {
    courseSub = s;
    emit(SelectionState());
  }

  void stageSelect(String s) {
    courseStage = s;
    emit(SelectionState());
  }

  void levelSelect(String s) {
    courseLevel = s;
    emit(SelectionState());
  }

  void termSelect(String s) {
    courseTerm = s;
    emit(SelectionState());
  }

  String firstName = CacheHelper.getData(key: 'firstName');
  String lastName = CacheHelper.getData(key: 'lastName');
  String userName = CacheHelper.getData(key: 'userName');
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
    userName = CacheHelper.getData(key: 'userName');
    bio = CacheHelper.getData(key: 'biography') ?? "";
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
      await sendRequest(
          method: 'updateImage', url: updateImage, formData: formData);
      emit(UpdateProfileImageSuccessState());
      return 200;
    } catch (error) {
      if (error == 401) {
        emit(SessionEndedState());
        return 401;
      } else if (error is DioException) {
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
      Response response = await sendRequest(
          method: 'patch', url: updateDataPatch, listMap: updateData);
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
      if (error == 401) {
        emit(SessionEndedState());
      } else if (error is DioException) {
        emit(UpdateUserDataErrorState());
      }
    }
    return 0;
  }

  bool back = true;

  void isBack() {
    back = false;
    emit(EnableButtonBackState());
  }

  Future<void> payManager(int coursePrice, String description) async {
    isLoading = true;
    emit(PaymentManagerLoadingState());
    PaymobManager()
        .getPaymentKey(
      coursePrice,
      "EGP",
      description,
    )
        .then((String paymentKey) {
      // launchUrl(Uri.parse(
      //     "https://accept.paymob.com/api/acceptance/iframes/830423?payment_token=$paymentKey"));
      Get.to(()=>WebViewScreen(paymentKey: paymentKey,));
    }).catchError((e) {
      emit(PaymentManagerErrorState());
    });
  }

  Future<void> onPaymentComplete() async {
    try {
      await DioHelper.getData(
          url: orderIdEndpoint,
          query: {'orderId': CacheHelper.getData(key: 'orderId')});
      emit(PaymentManagerSuccessState());
    } catch (e) {
      emit(PaymentManagerErrorState());
    }
  }

  Future<int?> logOut(String refreshToken) async {
    emit(LogOutLoadingInsState());
    try {
      await sendRequest(
          method: 'delete', url: logout, data: {'refreshToken': refreshToken});
      await clearCache();
      emit(LogOutSuccessState());
      return 200;
    } catch (error) {
      if (error is int && error == 401) {
        await clearCache();
        emit(LogOutSuccessState());
        return 200;
      } else {
        return 404;
      }
    }
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
          return await DioHelper.getData(url: url);
        case 'post':
          return await DioHelper.postData(url: url, data: data!);
        case 'put':
          return await DioHelper.putData(url: url, data: data!);
        case 'delete':
          return await DioHelper.delete(
            url: url,
            data: data,
          );
        case 'patch':
          return await DioHelper.patchData(url: url, data: listMap!);
        case 'updateimage':
          return await DioHelper.updateImage(url: url, data: formData);
        default:
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

  bool isPublished = false;
  bool isLoading = false;

  List<InstructorCourseModel> insCourses=[];
  void getCourses() {
    emit(InstructorGetCoursesLoadingState());
    sendRequest(method: 'get', url: getInstructorCourses)
        .then((value) {
      insCourses = (value.data as List)
          .map((course) => InstructorCourseModel.fromJson(course))
          .toList();
      emit(InstructorGetCoursesSuccessState());
    }).catchError((error) {
      emit(InstructorGetCoursesErrorState());
    });
  }
  Future<void> showPopMassage(context,bool isPublish,int id) async {
    if(!isPublish){
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogScreen(courseId: id,);
          });
      emit(ShowPopMassageState());
    }
  }

  Future<void> publishCourse(int courseId) async {
    emit(PublishCourseLoadingState());
    try {
      await sendRequest(
          method: 'post', url: "$instructorCoursePublish$courseId");
      print(courseId);
      emit(PublishCourseSuccessState());
    } catch (error) {
      if (error is int && error == 401) {
        emit(SessionEndedState());
      } else {
        emit(PublishCourseErrorState());
      }
    }
  }
}
