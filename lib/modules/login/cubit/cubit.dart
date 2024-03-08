import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_and_user_data_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
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
      print(value.statusCode);
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromJson(value.data);
        if (loginModel.emailConfirmed) {
          String payLoad = loginModel.jwt!.split('.')[1];
          int padLength = (4 - payLoad.length % 4) % 4;
          String paddedPayload= payLoad.padRight(payLoad.length + padLength, '=');
          String decodedString = utf8.decode(base64.decode(paddedPayload));
          Map<String, dynamic> decodedMap = json.decode(decodedString);
          userData = UserData.fromJson(decodedMap);
          CacheHelper.saveData(key: 'jwt', value: loginModel.jwt);
          CacheHelper.saveData(key: 'role', value: userData.role.toLowerCase());
          CacheHelper.saveData(key: 'firstName', value: userData.firstName);
          CacheHelper.saveData(key: 'lastName', value: userData.lastName);
          CacheHelper.saveData(key: 'email', value: userData.email);
          CacheHelper.saveData(key: 'biography', value: loginModel.biography);
          CacheHelper.saveData(key: 'profilePicture', value: loginModel.profilePicture);
          emit(LoginSuccessState());
        } else if(!loginModel.emailConfirmed){
          emit(LoginNotConfirmedState());
        }
      }
    }).catchError((error) {
      print(error.toString());
      isLoading = false;
      if (error.toString().contains('404')) {
        emit(LoginNotFoundState());
      }
     else if (error.toString().contains('400')) {
        emit(FormatErrorState());
      }
     else
       {
         emit(LoginErrorState(error.toString()));
       }

    });
  }

  void sendResetCode({
    required String email,
    required bool reset,
  }) {
    DioHelper.postData(
      url: sendCode,
      data: {
        'email': email,
        'reset': reset,
      },
    ).then((value) {
      print(value.statusCode);
      emit(SendResetCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendResetCodeErrorState(error.toString()));
    });
  }

  void validateResetCode({
    required String? email,
    required String? code,
  }) {
    emit(ValidateResetPasswordLoadingState());
    isLoading = true;
    DioHelper.postData(
      url: validateReset,
      data: {
        'email': email,
        'code': code,
      },
    ).then((value) {
      isLoading = false;
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(ValidateResetPasswordSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      isLoading = false;
      emit(ValidateResetPasswordErrorState(error.toString()));
    });
  }

  void userResetPassword({
    required String? email,
    required String? newPassword,
  }) {
    emit(ResetPasswordLoadingState());
    isLoading = true;
    DioHelper.postData(
      url: resetPassword,
      data: {
        'email': email,
        'newPassword': newPassword,
      },
    ).then((value) {
      isLoading = false;
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(ResetPasswordSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      isLoading = false;
        emit(ResetPasswordErrorState(error.toString()));
    });
  }

  void sendConfirm({
    required String email,
  }) {
    DioHelper.postData(
      url: sendCode,
      data: {
        'email': email,
      },
    ).then((value) {
      print(value.statusCode);
      emit(SendConfirmSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SendConfirmErrorState(error.toString()));
    });
  }

}
