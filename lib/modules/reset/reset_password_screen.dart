import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;
  ResetPasswordScreen({super.key , required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعادة تعيين كلمة السر'),
      ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){
          if(state is ResetPasswordSuccessState)
            {
              navigateAndFinish(context, const LoginScreen());
            }
        },
        builder: (context , state ){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: screenWidth*3/4,
                        height: screenWidth*3/4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('Assets/forgetpassword.png',),fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Text('رجاءاً ادخل كلمة السر الجديدة',
                      style: font.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: passwordController1,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '!'' لا يمكن ترك هذه الخانة فارغة';
                        }
                        if(value.length<8)
                          {
                            return '!'' كلمة المرور يجب ان لا تقل عن ٨ احرف';
                          }
                        return null;
                      },
                      label: 'كلمة المرور الجديدة',
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: LoginCubit.get(context).prefixIcon,
                      isPassword: LoginCubit.get(context).isPassword,
                      prefixPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    defaultFormField(
                      controller: passwordController2,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '!'' لا يمكن ترك هذه الخانة فارغة';
                        }
                        if(value != passwordController1.text)
                          {
                            return '!'' كلمة المرور غير متطابقة';
                          }
                        return null;
                      },
                      label: 'إعادة كتابة كلمة المرور',
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: LoginCubit.get(context).prefixIcon,
                      isPassword: LoginCubit.get(context).isPassword,
                      prefixPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 20.0,),
                    usedButton(
                      atEnd: false,
                      paddingSize: 10.0,
                      isLoading: LoginCubit.get(context).isLoading,
                      text: "التالي",
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          LoginCubit.get(context).userResetPassword(email: email, newPassword: passwordController1.text);
                        }
                      },
                      context: context,
                      color: Theme.of(context).canvasColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
