import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/models/attachment_model.dart';
import 'package:graduation_project/models/chat_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/notification/notification.dart';
import 'package:graduation_project/modules/student/payMob_manager/payMob_manager.dart';
import 'package:graduation_project/modules/student/discovery/search_screen.dart';
import 'package:graduation_project/modules/student/discovery/home_screen.dart';
import 'package:graduation_project/modules/student/payMob_manager/web_view.dart';
import 'package:graduation_project/modules/student/profile/profile.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/lesson_model.dart';
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

  int listNum = 0;

  void changeListNum(int index) {
    listNum = index;
    emit(ChangeListNumberState());
  }

  bool startSearching = false;

  void showSearchFilter(context) async {
    await showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) {
          return const MultiSelect();
        });
    emit(StartSearchState());
  }

  List<CourseModel> searchList = [];

  void searchFunction(String? keyWord, String searchBy) {
    searchList = [];
    emit(SearchLoadingState());
    sendRequest(method: 'get', url: "$getAllCoursesEndPoint/$searchBy/$keyWord")
        .then((value) {
      searchList = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }

  List<String> category = [
    "CourseName",
    "CourseAcademicYear",
    "InstructorName",
    "CourseStage",
  ];
  final categorySelections = [
    false,
    false,
    false,
    false,
  ];
  String? catSearchBy;
  String? searchText;
  bool startSearch = false;

  void startSearchFunction(String text) {
    if (text.isNotEmpty) {
      startSearch = true;
    } else {
      startSearch = false;
    }
    emit(StartSearchState());
  }

  void changeTheSearchByFunction(int index) {
    for (int i = 0; i < 4; i++) {
      if (i == index) {
        categorySelections[index] = !categorySelections[index];
        continue;
      }
      categorySelections[i] = false;
    }
    catSearchBy = category[index];
    emit(ChangeTheSearchCategoryState());
  }

  List<CourseModel> allCourses = [];
  List<CourseModel> enrolledCourses = [];
  List<CourseModel> topRatedCourses = [];
  List<CourseModel> topSalesCourses = [];

  void getCourses(int pageNumber) {
    emit(GetCoursesLoadingState());
    sendRequest(method: 'get', url: "$getAllCoursesEndPoint$pageNumber")
        .then((value) {
      allCourses = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(GetCoursesSuccessState());
    }).catchError((error) {
      emit(GetCoursesErrorState());
    });
  }

  bool enrolled = false;

  void getEnrolledCourses(int pageNumber) {
    enrolled = true;
    emit(GetCoursesEnrolledLoadingState());
    //getAllCoursesEndPoint is equal to getEnrolledCoursesEndPoint
    sendRequest(
            method: 'get', url: "Course/${pageNumber.toString()}/for-student")
        .then((value) {
      enrolledCourses = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      enrolled = true;
      emit(GetCoursesEnrolledSuccessState());
    }).catchError((error) {
      emit(GetCoursesEnrolledErrorState());
    });
  }

  void getTopRatedCourses() {
    emit(GetTopRatedCoursesLoadingState());
    sendRequest(method: 'get', url: getTopRatedCoursesEndPoint).then((value) {
      topRatedCourses = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(GetTopRatedCoursesSuccessState());
    }).catchError((error) {
      emit(GetTopRatedCoursesErrorState());
    });
  }

  void getTopSalesCourses() {
    emit(GetTopSalesCoursesLoadingState());
    sendRequest(method: 'get', url: getTopSalesCoursesEndPoint).then((value) {
      topSalesCourses = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(GetTopSalesCoursesSuccessState());
    }).catchError((error) {
      emit(GetTopSalesCoursesErrorState());
    });
  }

  CourseDetailsModel courseDetails = CourseDetailsModel(
    instructorName: '',
    academicLevel: '',
    lessonName: '',
    url: '',
    period: '',
    courseDescription: '',
    reviews: [],
  );

  Future getCourseDetails(int courseId) async {
    emit(GetCoursesDetailsLoadingState());
    try {
      courseDetails = CourseDetailsModel(
          instructorName: '',
          academicLevel: '',
          lessonName: '',
          url: '',
          period: '',
          courseDescription: '',
          reviews: []);
      var result = await sendRequest(
          method: 'get', url: "$getCourseDetailsEndPoint$courseId");
      courseDetails = CourseDetailsModel.fromJson(result.data);
      emit(GetCoursesDetailsSuccessState());
    } catch (e) {
      emit(GetCoursesDetailsErrorState());
    }
  }

  List<CourseModel> favouriteList = [];

  void addToFavourite(CourseModel course) {
    emit(AddToFavouriteLoadingState());
    sendRequest(
        method: 'post',
        url: "$addToFavouriteEndPoint${course.courseId}",
        data: {}).then((value) {
      for (int i = 0; i < favouriteList.length; i++) {
        if (course.favourite) {
          favouriteList.remove(course);
        } else {
          favouriteList.add(course);
        }
      }
      course.favourite = !course.favourite;
      emit(AddToFavouriteSuccessState());
    }).catchError((error) {
      emit(AddToFavouriteErrorState());
    });
  }

  void getFavouriteList() {
    emit(GetFavouriteListLoadingState());
    sendRequest(method: 'get', url: getFavourites).then((value) {
      favouriteList = (value.data as List)
          .map((course) => CourseModel.fromJson(course))
          .toList();
      emit(GetFavouriteListSuccessState());
    }).catchError((error) {
      emit(GetFavouriteListErrorState());
    });
  }

  Future<void> payManager(
      int coursePrice, String description, CourseModel course) async {
    isLoading = true;
    emit(PaymentManagerLoadingState());
    PaymobManager()
        .getPaymentKey(
      coursePrice,
      "EGP",
      description,
    )
        .then((String paymentKey) {
      Get.to(() => WebViewScreen(
            paymentKey: paymentKey,
            course: course,
          ));
    }).catchError((error) {
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

  //student data
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
    emit(StudentHasImageState());
  }

  void getUser() {
    firstName = CacheHelper.getData(key: 'firstName') ?? '';
    lastName = CacheHelper.getData(key: 'lastName') ?? '';
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
      Response response = await sendRequest(
          method: 'postWithFormData', url: updateImage, formData: formData);
      emit(UpdateProfileImageSuccessState());
      return response.statusCode;
    } catch (error) {
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

  Future<dynamic> sendRequest(
      {required String method,
      required String url,
      Map<String, String>? data,
      Map<String, dynamic>? query,
      List<Map<String, dynamic>>? listMap,
      FormData? formData}) async {
    try {
      switch (method) {
        case 'get':
          return await DioHelper.getData(url: url, query: query);
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
        case 'postWithFormData':
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
                query: query,
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
    emit(LogOutLoadingState());
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
    // emit(LogOutSuccessState());
  }

  bool isLoading = false;

  List<LessonModel> lessons = [];

  Future getLessons(int courseId) async {
    lessons = [];
    emit(GetCourseLessonsLoadingState());
    try {
      var result =
          await sendRequest(method: 'get', url: "$lessonEndPoint/$courseId");
      result.data.forEach((value) {
        lessons.add(LessonModel.fromJson(value));
      });
      emit(GetCourseLessonsSuccessState());
    } catch (e) {
      emit(GetCourseLessonsErrorState());
    }
  }

  List<AttachmentModel> attachments = [];

  void getAttachments(int courseId) {
    emit(GetCourseAttachmentsLoadingState());
    sendRequest(method: 'get', url: "$getAttachmentsEndPoint$courseId")
        .then((value) {
      attachments = (value.data as List)
          .map((attachment) => AttachmentModel.fromJson(attachment))
          .toList();
      emit(GetCourseAttachmentsSuccessState());
    }).catchError((error) {
      emit(GetCourseAttachmentsErrorState());
    });
  }

  List<AssignmentModel> assignments = [];

  void getAssignments(int courseId) {
    emit(GetCourseAssignmentsLoadingState());
    sendRequest(method: 'get', url: "$getAssignmentsEndPoint$courseId")
        .then((value) {
      assignments = (value.data as List)
          .map((assignment) => AssignmentModel.fromJson(assignment))
          .toList();
      emit(GetCourseAssignmentsSuccessState());
    }).catchError((error) {
      emit(GetCourseAssignmentsErrorState());
    });
  }

  Future<void> uploadSolution(
      {required int assignmentId,
      required String description,
      required File? file}) async {
    emit(AddAssignmentSolutionLoadingState());
    FormData formData = FormData();
    formData = FormData.fromMap({
      'assignmentId': assignmentId,
      'description': description,
      'file': await MultipartFile.fromFile(
        file!.path,
        filename: file.path.split('/').last,
      ),
    });
    sendRequest(
            method: 'postWithFormData',
            url: uploadSolutionEndPoint,
            formData: formData)
        .then((value) {
      emit(AddAssignmentSolutionSuccessState());
    }).catchError((error) {
      emit(AddAssignmentSolutionErrorState());
    });
  }

  File? pickedFile;
  PlatformFile? file;

  Future<void> pickFile() async {
    pickedFile = null;
    file = null;
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'txt', 'ppt']);
    file = result?.files.first;
    if (result != null) {
      pickedFile = File(result.files.single.path!);
      emit(FilePickedSuccessState());
    } else {
      emit(FilePickedErrorState());
    }
  }

  Future<void> addRate(int courseId, double rate, String? review) async {
    emit(AddRateLoadingState());
    try {
      await sendRequest(method: 'post', url: "Course/rate", data: {
        "courseId": courseId.toString(),
        "rate": rate.toString(),
        "feedback": review ?? ''
      });
      emit(AddRateSuccessState());
    } catch (error) {
      if (error == 401) {
        emit(SessionEndedState());
      } else {
        emit(AddRateErrorState());
      }
    }
  }

  GradeModel? gradeModel;
  bool hasGrade = false;

  Future<void> getSolutionGrade(int assignmentId) async {
    hasGrade = false;
    emit(GetAssignmentGradeLoadingState());
    try {
      var response =
          await sendRequest(method: 'get', url: "Course/$assignmentId/grade");
      gradeModel = GradeModel.fromJson(response.data);
      hasGrade = true;
      emit(GetAssignmentGradeSuccessState());
    } catch (error) {
      hasGrade = false;
      if (error == 401) {
        emit(SessionEndedState());
      } else {
        emit(GetAssignmentGradeErrorState());
      }
    }
  }

  List<MessageModel> chat = [];

  Future<void> getChat(int courseId, int pageNumber) async {
    emit(GetChatLoadingState());
    try {
      var result = await sendRequest(
          method: 'get', url: "Course/$courseId/chat/$pageNumber");
      chat = (result.data as List)
          .map((message) => MessageModel.fromJson(message))
          .toList();
      emit(GetChatSuccessState());
    } catch (error) {
      if (error == 401) {
        emit(SessionEndedState());
      } else {
        emit(GetChatErrorState());
      }
    }
  }

  void addMessageToChats(String userName, String content) {
    var dateTime = DateTime.now();
    String dateT = dateTime.toString().split('.')[0];
    String date = dateTime.toString().split(' ')[0];
    String time =
        "${dateT.split(' ')[1].split(':')[0]}:${dateT.split(' ')[1].split(':')[1]}";
    MessageModel message = MessageModel(userName, date + time, content);
    chat.add(message);
    emit(MessageAddToChatState());
  }
}
