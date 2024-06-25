import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:graduation_project/models/assignment_model.dart';
import 'package:graduation_project/models/attachment_model.dart';
import 'package:graduation_project/models/chat_model.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/models/lesson_model.dart';
import 'package:graduation_project/models/students_model.dart';
import 'package:graduation_project/modules/student/payMob_manager/payMob_manager.dart';
import 'package:graduation_project/modules/student/payMob_manager/web_view.dart';
import 'package:graduation_project/modules/tutor/home/courses/assignments/show_assignment.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';
import 'package:image_picker/image_picker.dart';
import '../../../modules/tutor/home/courses/courses.dart';
import '../../../modules/tutor/home/home.dart';
import '../../../modules/tutor/notification/notification.dart';
import '../../../modules/tutor/profile/profile.dart';
import 'instructor_states.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:file_picker/file_picker.dart';


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

  String courseStage = 'PrimaryStage';
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
  ImageProvider<Object> imageProvider = const AssetImage("Assets/profile/man_1.png");

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

  File? video;
  String? videoPeriod;

  Future<void> pikeVideoFromGallery() async {
    int h = 0;
    int m = 0;
    int s = 0;
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
      final FlutterFFprobe flutterFProm = FlutterFFprobe();
      flutterFProm.getMediaInformation(video!.path).then((info) {
        String tt = info.getMediaProperties()!['duration'];
        int t = int.parse(tt.split('.')[0]);
        if (t >= 3600) h = t ~/ 3600;
        if (t >= 60) m = t ~/ 60 % 60;
        s = t % 60;
        videoPeriod = "2024-08-08T${h.toString().padLeft(2,'0')}:${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}Z";
      });
      emit(VideoPickedSuccessState());
    } else {
      emit(VideoPickedErrorState());
    }
  }

  // Future<void> pikeVideoFromCamera() async {
  //   final pickedVideo = await picker.pickVideo(source: ImageSource.camera);
  //   if (pickedVideo != null) {
  //     video = File(pickedVideo.path);
  //     _controller = VideoPlayerController.file(video!)
  //       ..initialize().then((_) {
  //         videoPeriod = _controller!.value.duration as DateTime?;
  //       });
  //     print(videoPeriod);
  //     emit(VideoPickedSuccessState());
  //   } else {
  //     emit(VideoPickedErrorState());
  //   }
  // }

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
          method: 'postWithFormData', url: updateImage, formData: formData);
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

      Get.to(() => WebViewScreen(
            paymentKey: paymentKey,
          ));
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
      switch (method) {
        case 'get':
          return await DioHelper.getData(url: url);
        case 'post':
          return await DioHelper.postData(url: url, data: data!);
        case 'put':
          return await DioHelper.putData(url: url, data: data!);
        case 'delete':
          return await DioHelper.delete(url: url, data: data);
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

  List<InstructorCourseModel> insCourses = [];

  void getCourses() {
    print(CacheHelper.getData(key: 'jwt'));
    emit(GetInstCoursesLoadingState());
    sendRequest(method: 'get', url: getInstructorCourses).then((value) {
      insCourses = (value.data as List)
          .map((course) => InstructorCourseModel.fromJson(course))
          .toList();
      emit(GetInstCoursesSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetInstCoursesErrorState());
    });
  }

  Future<void> showPopMassage(context, bool isPublish, int id) async {
    if (!isPublish) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogScreen(
              courseId: id,
            );
          });
      emit(ShowPopMassageState());
    }
  }

  Future<void> publishCourse(int courseId) async {
    emit(PublishCourseLoadingState());
    try {
      await sendRequest(
          method: 'post',
          url: '$instructorCoursePublish$courseId',
          data: {});
      for (int i=0;i<insCourses.length;i++) {
        if (insCourses[i].courseId == courseId) {
          insCourses[i].isPublished = true;
          break;
        }
      }
      emit(PublishCourseSuccessState());
    } catch (error) {
      if (error is int && error == 401) {
        emit(SessionEndedState());
      } else {
        emit(PublishCourseErrorState());
      }
    }
  }

  List<LessonModel> lessons = [];
  Future<void> getLessons(int courseId) async{
    lessons=[];
    emit(GetInstCourseLessonsLoadingState());
    sendRequest(method: 'get', url: "$lessonEndPoint/$courseId").then((value) {
      print(value.data);
      lessons = (value.data as List)
          .map((lesson) => LessonModel.fromJson(lesson))
          .toList();
      emit(GetInstCourseLessonsSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetInstCourseLessonsErrorState());
    });
  }

  Future<void> addLesson({
    required int courseId,
    required String name,
    required File? video,
    required String? period,
  }) async {
      emit(AddLessonLoadingState());
      FormData formData = FormData();
      if (video != null) {
        formData = FormData.fromMap({
          'courseId':courseId,
          'name':name,
          'video':await MultipartFile.fromFile(
            video.path,
            filename: video.path.split('/').last,
          ),
          'period':period,
        });
      }
      try {
        var result = await DioHelper.updateImage(url: lessonEndPoint,data: formData);
        print(result.data);
        emit(AddLessonSuccessState());
      } catch (error) {
        if (error == 401) {
          emit(SessionEndedState());
        } else if (error is DioException) {
          emit(AddLessonErrorState());
        }
      }
  }


  //add description
  Future<void> addDescription(int courseId,String description) async{
    emit(AddDescriptionLoadingState());
    try{
      sendRequest(
          method: 'post',
          url: "$addDescriptionEndPoint$courseId",
          data: {'description':description}
      );
      emit(AddDescriptionSuccessState());
    }catch(e){
      if(e == 401){
        emit(SessionEndedState());
      }
      else{
      emit(AddDescriptionErrorState());
    }
    }
  }
  // course Students
  List<StudentModel> students = [];
  Future<void> getStudents(int courseId) async{
    students=[];
    emit(InstGetStudentsLoadingState());
    sendRequest(method: 'get', url: "$instGetStudents$courseId").then((value) {
      students = (value.data as List)
          .map((student) => StudentModel.fromJson(student))
          .toList();
      emit(InstGetStudentsSuccessState());
    }).catchError((error) {
      emit(InstGetStudentsErrorState());
    });
  }
  void addAttachment(int courseId,String description,File? file) async{
    emit(AddAttachmentLoadingState());
    FormData formData = FormData();
    formData = FormData.fromMap({
      'courseId':courseId,
      'description':description,
      'file':await MultipartFile.fromFile(
        file!.path,
        filename: file.path.split('/').last,
      ),
    });
    sendRequest(
        method: 'postWithFormData',
        url: addAttachmentEndPoint,
        formData:formData
    ).then((value) {
      emit(AddAttachmentSuccessState());
    }).catchError((error) {
      emit(AddAttachmentErrorState());
    });
  }

  List<AttachmentModel> attachments = [];
  void getAttachments(int courseId) {
    attachments = [];
    emit(InstGetAttachmentsLoadingState());
    sendRequest(method: 'get', url: "$getAttachmentsEndPoint$courseId").then((value) {
      attachments = (value.data as List)
          .map((attachment) => AttachmentModel.fromJson(attachment))
          .toList();
      emit(InstGetAttachmentsSuccessState());
    }).catchError((error) {
      emit(InstGetAttachmentsErrorState());
    });
  }

  Future<void> addAssignment({
      required int courseId,
      required String description,
      required int grade,
      required String deadLine,
      required File? file
  }) async{
    emit(AddAssignmentLoadingState());
    FormData formData = FormData();
    String date = '2024-06-30T${deadLine}Z';
    formData = FormData.fromMap ({
      'courseId':courseId,
      'description':description,
      'grade':grade,
      'deadLine':date,
      'file':await MultipartFile.fromFile(
        file!.path,
        filename: file.path.split('/').last,
      ),
    });
    sendRequest(
        method: 'postWithFormData',
        url: addAssignmentEndPoint,
        formData:formData
    ).then((value) {
      emit(AddAssignmentSuccessState());
    }).catchError((error) {
      emit(AddAssignmentErrorState());
    });
  }

  List<AssignmentModel> assignments = [];
  void getAssignments(int courseId) {
    assignments = [];
    emit(InstGetAssignmentsLoadingState());
    sendRequest(method: 'get', url: "$getAssignmentsEndPoint$courseId").then((value) {
      assignments = (value.data as List)
          .map((assignment) => AssignmentModel.fromJson(assignment))
          .toList();
      emit(InstGetAssignmentsSuccessState());
    }).catchError((error) {
      emit(InstGetAssignmentsErrorState());
    });
  }

  File? pickedFile;
  PlatformFile? file;
  Future<void> pickFile() async {
    pickedFile = null;
    file = null;
    final result = await FilePicker.platform.pickFiles(
        type:FileType.custom,
        allowedExtensions: ['pdf','txt','ppt']
    );
    file = result?.files.first;
    if (result != null) {
      pickedFile = File(result.files.single.path!);
      emit(FilePickedSuccessState());
    } else {
      emit(FilePickedErrorState());
    }
  }

  void clear(){
    pickedFile = null;
    file = null;
    emit(FileClearState());
  }

  Future<TimeOfDay> showTime(context, time)async {
    TimeOfDay? newTime = await showTimePicker(context: context,initialTime: time!);
    if(newTime != null){
      time = newTime;
      emit(TimePickedSuccessState());
    }
    print(time);
    return time;
  }

  List<SolutionModel> assignmentSolutions = [];
  void getSolutions(int assignmentId) {
    assignmentSolutions = [];
    emit(InstGetAssignmentsLoadingState());
    sendRequest(method: 'get', url: "Course/assignment/$assignmentId/solutions").then((value) {
      assignmentSolutions = (value.data as List)
          .map((solution) => SolutionModel.fromJson(solution))
          .toList();
      emit(InstGetAssignmentsSuccessState());
    }).catchError((error) {
      emit(InstGetAssignmentsErrorState());
    });
  }

  Future<void> addGrade(int studentId,int assignmentId,double grade) async{
    emit(AddGradeForSolutionLoadingState());
    try{
      await sendRequest(method: 'post', url: "Course/$studentId/$assignmentId/grade/$grade",data: {});
      emit(AddGradeForSolutionSuccessState());
    }catch(error){
      if(error == 401){
        emit(SessionEndedState());
      }
      else{
        emit(AddGradeForSolutionErrorState());
      }
    }
  }

  void showAddGradeForm(BuildContext context, {required int studentId, required int assignmentId}) async {
    await showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) {
          return AddGrade(studentId: studentId, assignmentId: assignmentId,);
        });
    emit(ShowAddGradeDialogState());
  }

  List<MessageModel> chat = [];
  Future<void> getChat(int courseId,int pageNumber) async {
    emit(GetChatLoadingState());
    try{
      var result = await sendRequest(method: 'get', url: "Course/$courseId/chat/$pageNumber");
      chat = (result.data as List)
          .map((message) => MessageModel.fromJson(message))
          .toList();
      emit(GetChatSuccessState());
    }catch (error){
      if(error == 401){
        emit(SessionEndedState());
      }
      else{
        emit(GetChatErrorState());
      }
    }
  }
  void addMessageToChats(String userName,String content){
    var dateTime = DateTime.now();
    String dateT = dateTime.toString().split('.')[0];
    String date = dateTime.toString().split(' ')[0];
    String time = "${dateT.split(' ')[1].split(':')[0]}:${dateT.split(' ')[1].split(':')[1]}";
    MessageModel message = MessageModel(userName,date+time,content);
    chat.add(message);
    emit(MessageAddToChatState());
  }

  double typingBoxIndex(bool typing){
    if(typing){
      return -5.6;
    }else{
      return 0;
    }
  }
}
