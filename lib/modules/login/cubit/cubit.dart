import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/network/remote/end_points.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  IconData prefixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
  // Change accept conditions
  bool acceptCondition = false;
  void changeAcceptConditions(){
    acceptCondition = !acceptCondition;
    emit(ChangeAcceptOfConditions());
  }
  late LoginModel loginModel;
  late UserData userData;
  void userLogin({
    required String? email,
    required String? password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      print(value.statusCode);
      if (value.statusCode == 200)
        {
          loginModel = LoginModel.fromJson(value.data);
          if(loginModel.emailConfirmed)
            {
              String payLoad = loginModel.jwt.split('.')[1];
              String decodedData = utf8.decode(base64.decode(payLoad));
              userData = UserData.fromJson(decodedData);
              emit(LoginSuccessState());
            }
          else {
            emit(LoginNotConfirmedState());
          }
        }
      if(value.statusCode == 404)
        {
          emit(LoginNotFoundState());
        }
      if(value.statusCode == 400)
      {
        emit(LoginFormatErrorState());
      }
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}