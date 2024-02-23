import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/models/login_model.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context)=> BlocProvider.of(context);

  // Control to visible or invisible password
  IconData prefixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  bool isLoading = false;

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

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String role,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role,
      },
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(RegisterSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
  void sendConfirm({
    required String email,
  }) {
    DioHelper.postData(
      url: SEND,
      data: {
        'email': email,
      },
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(SendConfirmSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(SendConfirmErrorState(error.toString()));
    });
  }

  void validateCodeConfirm({
    required String email,
    required String code,
  }) {
    emit(CheckCodeConfirmLoadingState());
    DioHelper.postData(
      url: VALIDATE,
      data: {
        'email': email,
        'code': code,
      },
    ).then((value) {
      print(value.statusCode);
      if (value.statusCode == 200) {
        emit(CheckCodeConfirmSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(CheckCodeConfirmErrorState(error.toString()));
    });
  }

}