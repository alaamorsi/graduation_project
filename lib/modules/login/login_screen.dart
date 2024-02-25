import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/register/Confirm_Screen.dart';
import 'package:graduation_project/modules/reset/forget_password_screen1.dart';
import 'package:graduation_project/modules/register/second_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../shared/component/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        role = CacheHelper.getData(key: 'role');
        if (state is LoginSuccessState) {
          if (role == 'student') {
            navigateAndFinish(context, const StudentLayout());
          } else if (role == 'instructor') {
            navigateAndFinish(context, const StudentLayout());
            print('معلش عشان لسه معملناش الصفحة');
          }
        }
        if(state is LoginNotConfirmedState)
          {
            LoginCubit.get(context).sendConfirm(email: emailController.text);
            navigateAndFinish(context, ConfirmScreen(email: emailController.text));
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
                          'تسجيل الدخول',
                          style: font.copyWith(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).canvasColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'سجل الأن لتستمتع بخدماتنا الرائعة',
                          style:
                              font.copyWith(fontSize: 13.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return '!' ' لا يمكن ترك هذه الخانة فارغة';
                          } else if (!cubit.checkForNumbers(value)) {
                            return '!' ' البريد الإلكتروني غير صالح';
                          }
                          return null;
                        },
                        label: 'البريد الإلكتروني',
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty || value.length < 8) {
                          return '!' ' كلمة المرور يجب ان لا تقل عن ٨ احرف';
                        }
                        return null;
                      },
                      label: 'كلمة المرور',
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
                      text: "تسجيل الدخول",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      },
                      context: context,
                      color: Theme.of(context).canvasColor,
                    ),
                    const SizedBox(height: 10.0),
                    //didn't have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const SecondScreen());
                          },
                          child: Text("انشاء حساب",
                              style: font.copyWith(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "ليس لديك حساب ؟",
                          style:
                              font.copyWith(color: Colors.grey, fontSize: 14.0),
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
                          child: Text("هل نسيت كلمة السر؟",
                              style: font.copyWith(
                                  color: Theme.of(context).canvasColor,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'أو',
                          style: font.copyWith(
                              fontSize: 15.0,
                              color: Theme.of(context).canvasColor),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    //google logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            foregroundImage: const AssetImage("Assets/G.jpg"),
                            child: InkWell(
                              onTap: () {},
                            ),
                          ),
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
