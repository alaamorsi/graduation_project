import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/reset/reset_password_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class ForgetPasswordScreen2 extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;
  ForgetPasswordScreen2({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('هل نسيت كلمة السر؟'),
      ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){
          if (state is ValidateResetPasswordSuccessState)
            {
              navigateTo(context, ResetPasswordScreen(email: email,));
            }
        },
        builder: (context , state){
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
                          image: DecorationImage(image: AssetImage('Assets/check_email.png',),fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Text('رجاءاً ادخل رمز التحقق الذي تم ارساله',
                      style: font.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),
                    Text('لفد ارسلنا الي البريد الإلكتروني الخاص بك رمز التحقق',
                      style: font.copyWith(fontSize: 16.0,),textDirection: TextDirection.rtl),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: codeController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return '!'' لا يمكن ترك هذه الخانة فارغة';
                        }
                        return null;
                      },
                      label: 'رمز التحقق',
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
                          LoginCubit.get(context).validateResetCode(email: email, code: codeController.text);
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
