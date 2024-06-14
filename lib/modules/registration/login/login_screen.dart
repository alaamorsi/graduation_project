import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/tutor/instructor_layout.dart';
import '../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../shared/component/constant.dart';
import '../register/Confirm_Screen.dart';
import '../register/second_screen.dart';
import '../reset/forget_password_screen1.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        role = CacheHelper.getData(key: 'role');
        if (state is LoginSuccessState) {
          if(!firstInstall) showToast(title: 'welcome back'.tr, description: "login success".tr,context: context, state: MotionState.success);
          if (role == 'student') {
            Get.offAll(const StudentLayout());
            StudentCubit.get(context).getImage();
            StudentCubit.get(context).getUser();
          } else if (role == 'instructor') {
            Get.offAll(const InstructorLayout());
            InstructorCubit.get(context).getImage();
            InstructorCubit.get(context).getData();
          }
        }
        else if(state is LoginNotConfirmedState) {
          showToast(title: 'Info'.tr, description: "your email is not confirmed ,check your gmail!".tr,context: context, state: MotionState.info);
          LoginCubit.get(context).sendConfirm(email: emailController.text);
          navigateAndFinish(context, ConfirmScreen(email: emailController.text));
        }
        else if(state is FormatErrorState){
          showToast(title: 'Error'.tr, description: "email format error".tr,context: context, state: MotionState.error);
        }
        else if(state is LoginNotFoundState){
          showToast(title: 'Error'.tr, description: "email not found".tr,context: context, state: MotionState.error);
        }
        else if(state is LoginErrorState){
          showToast(title: 'Error'.tr, description: "email or password is wrong".tr,context: context, state: MotionState.error);
        }
      },
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'login'.tr,
                          style: font.copyWith(
                              fontSize: 29.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register now to enjoy our great services'.tr,
                          style:
                              font.copyWith(fontSize: 13.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    defaultFormField(
                        context:context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty!'.tr;
                          } else if (!cubit.checkForNumbers(value)) {
                            return 'Invalid Email !'.tr;
                          }
                          return null;
                        },
                        label: 'email address'.tr,
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      context:context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be at least 8 characters!'.tr;
                        }
                        return null;
                      },
                      label: 'password'.tr,
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: LoginCubit.get(context).prefixIcon,
                      isPassword: LoginCubit.get(context).isPassword,
                      prefixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 30.0),
                    //login button
                    usedButton(
                      atEnd: false,
                      paddingSize: 13.0,
                      isLoading: cubit.isLoading,
                      text: "login".tr,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      context: context,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 10.0),
                    //didn't have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?".tr,
                          style:
                          font.copyWith(color: Colors.grey, fontSize: 12.0),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const SecondScreen());
                          },
                          child: Text("Create now".tr,
                              style: font.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            navigateTo(context, ForgetPasswordScreen1());
                          },
                          child: Text("Forgot password?".tr,
                              style: font.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
