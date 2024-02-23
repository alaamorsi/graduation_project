import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';

import '../../../shared/network/cache_helper.dart';

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

  // Change accept conditions
  bool acceptCondition = false;

  void changeAcceptConditions() {
    acceptCondition = !acceptCondition;
    emit(ChangeAcceptOfConditions());
  }
  bool isLoading = false;
  bool checkForNumbers(String input) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+(\.\w+)*');
    return regex.hasMatch(input);
  }

  late LoginModel loginModel;
  late UserData userData;

  void userLogin({
    required String? email,
    required String? password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        loginModel = LoginModel.fromJson(value.data);
        if (loginModel.emailConfirmed) {
          String payLoad = loginModel.jwt!.split('.')[1];
          String decodedString = utf8.decode(base64.decode(payLoad));
          Map<String, dynamic> decodedMap = json.decode(decodedString);
          userData = UserData.fromJson(decodedMap);
          CacheHelper.saveData(key: 'id', value: loginModel.jwt);
          CacheHelper.saveData(key: 'role', value: userData.role);
          emit(LoginSuccessState());
        } else if(!loginModel.emailConfirmed){
          emit(LoginNotConfirmedState());
        }
      }
    }).catchError((error) {
      if (error.toString().contains('404')) {
        emit(LoginNotFoundState());
      }
      if (error.toString().contains('400')) {
        emit(LoginFormatErrorState());
      }
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

}
