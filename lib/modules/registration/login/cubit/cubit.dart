import 'dart:convert';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_and_user_data_model.dart';
import 'package:graduation_project/modules/registration/login/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // Control to visible or invisible password
  IconData prefixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    prefixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  bool checkForNumbers(String input) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+(\.\w+)*');
    return regex.hasMatch(input);
  }

  late LoginModel loginModel;
  late UserData userData;
  bool isLoading = false;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());
    isLoading = true;
    DioHelper.postData(
      url: login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      isLoading = false;
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromJson(value.data);
        if (loginModel.emailConfirmed) {
          String payLoad = loginModel.jwt!.split('.')[1];
          int padLength = (4 - payLoad.length % 4) % 4;
          String paddedPayload =
              payLoad.padRight(payLoad.length + padLength, '=');
          String decodedString = utf8.decode(base64.decode(paddedPayload));
          Map<String, dynamic> decodedMap = json.decode(decodedString);
          userData = UserData.fromJson(decodedMap);
          CacheHelper.saveData(key: 'jwt', value: loginModel.jwt);
          CacheHelper.saveData(
              key: 'refreshToken', value: loginModel.refreshToken);
          CacheHelper.saveData(key: 'role', value: userData.role.toLowerCase());
          CacheHelper.saveData(key: 'firstName', value: userData.firstName);
          CacheHelper.saveData(key: 'lastName', value: userData.lastName);
          CacheHelper.saveData(key: 'email', value: userData.email);
          CacheHelper.saveData(key: 'id', value: userData.id);
          CacheHelper.saveData(key: 'userName', value: userData.userName);
          CacheHelper.saveData(
              key: 'biography',
              value: loginModel.biography ?? "enter your bio here");
          if (loginModel.profilePicture != null) {
            // Uint8List bytes = base64Decode(loginModel.profilePicture!);
            // String pictureStr = base64Encode(bytes);
            CacheHelper.saveData(key: 'profileStr', value: loginModel.profilePicture!);
          }
          emit(LoginSuccessState());
        } else if (!loginModel.emailConfirmed) {
          emit(LoginNotConfirmedState());
        }
      }
    }).catchError((error) {
      isLoading = false;
      if (error.toString().contains('404')) {
        emit(LoginNotFoundState());
      } else if (error.toString().contains('400')) {
        emit(FormatErrorState());
      } else {
        emit(LoginErrorState(error.toString()));
      }
    });
  }

  void sendResetCode({
    required String email,
    required bool reset,
  }) {
    isLoading = true;
    emit(SendResetCodeLoadingState());
    DioHelper.postData(
      url: sendCode,
      data: {
        'email': email,
        'reset': reset,
      },
    ).then((value) {
      isLoading = false;
      if (value.data['success'] == true) {
        CacheHelper.saveData(key: 'iToken', value: value.data['token']);
        emit(SendResetCodeSuccessState());
      } else {
        emit(SendResetCodeFailedState());
      }
    }).catchError((error) {
      isLoading = false;
      emit(SendResetCodeErrorState(error.toString()));
    });
  }

  void validateResetCode({
    required String? email,
    required String? code,
  }) {
    isLoading = true;
    emit(ValidateResetPasswordLoadingState());
    DioHelper.postData(
      url: validateReset,
      data: {
        'email': email,
        'code': code,
        'identityToken': CacheHelper.getData(key: 'iToken'),
      },
    ).then((value) {
      isLoading = false;
      if (value.statusCode == 200) {
        emit(ValidateResetPasswordSuccessState());
      }
    }).catchError((error) {
      isLoading = false;
      emit(ValidateResetPasswordErrorState(error.toString()));
    });
  }

  void userResetPassword({
    required String? email,
    required String? newPassword,
  }) {
    isLoading = true;
    emit(ResetPasswordLoadingState());
    DioHelper.postData(
      url: resetPassword,
      data: {
        'email': email,
        'newPassword': newPassword,
        'token': CacheHelper.getData(key: 'iToken'),
      },
    ).then((value) {
      isLoading = false;
      if (value.statusCode == 200) {
        emit(ResetPasswordSuccessState());
      }
    }).catchError((error) {
      isLoading = false;
      emit(ResetPasswordErrorState(error.toString()));
    });
  }

  void sendConfirm({
    required String email,
  }) {
    DioHelper.postData(
      url: sendCode,
      data: {'email': email, 'reset': false},
    ).then((value) {
      if (value.data['success'] == true) {
        CacheHelper.saveData(key: 'iToken', value: value.data['token']);
        emit(SendConfirmSuccessState());
      } else {
        emit(SendConfirmFailedState());
      }
    }).catchError((error) {
      emit(SendConfirmErrorState(error.toString()));
    });
  }
}
