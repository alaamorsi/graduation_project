import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/error_response.dart';
import 'package:graduation_project/models/login_and_user_data_model.dart';
import 'package:graduation_project/modules/registration/register/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Control to visible or invisible password
  IconData prefixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    prefixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  // Change accept conditions
  bool acceptCondition = false;

  void changeAcceptConditions() {
    acceptCondition = !acceptCondition;
    emit(ChangeAcceptOfConditions());
  }

  bool checkForNumbers(String input) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+(\.\w+)*');
    return regex.hasMatch(input);
  }

  late LoginModel loginModel;
  late UserData userData;
  RegisterResponse? errorResponse;

  bool isLoading = false;

  void userRegister({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String password,
    required String role,
  }) {
    isLoading = true;
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: signUp,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'email': email,
        'password': password,
        'role': role,
      },
    ).then((value) {
      isLoading = false;
      if (value.toString().contains('200')) {
        emit(RegisterSuccessState());
      }
    }).catchError((error) {
      isLoading = false;
      if (error.toString().contains('400')) {
        Map<String, dynamic> decodedMap =
            json.encode(error) as Map<String, dynamic>;
        errorResponse = RegisterResponse.fromJson(decodedMap);
        if (errorResponse!.success == false) {
          if (errorResponse!.hasRepeatedEmail == true) {
            emit(RegErrorRepeatedEmailState());
          } else if (errorResponse!.hasRepeatedUserName == true) {
            emit(RegErrorRepeatedUserNameState());
          }
        }
      } else if (error.toString().contains('500')) {
        emit(RegErrorServerErrorState());
      } else {
        emit(RegisterErrorState());
      }
    });
  }

  void sendConfirm({
    required String email,
  }) {
    DioHelper.postData(
      url: sendCode,
      data: {
        'email': email,
        'reset': false
      },
    ).then((value) {
      if (value.data['success'] == true) {
        CacheHelper.saveData(key: 'iToken', value: value.data['token']);
        emit(SendConfirmSuccessState());
      } else {
        emit(SendConfirmFailedState());
      }
    }).catchError((error) {
      emit(SendConfirmErrorState());
    });
  }

  void validateCodeConfirm({
    required String email,
    required String code,
  }) {
    emit(CheckCodeConfirmLoadingState());
    DioHelper.postData(
      url: validateEmail,
      data: {
        'email': email,
        'code': code,
        'identityToken': CacheHelper.getData(key: 'iToken'),
      },
    ).then((value) {
      emit(CheckCodeConfirmSuccessState());
    }).catchError((error) {
      emit(CheckCodeConfirmErrorState());
    });
  }
}
