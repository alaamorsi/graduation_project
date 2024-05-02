import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';
import '../login/login_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;
  ResetPasswordScreen({super.key , required this.email});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar:secondAppbar(
            context: context,
            title: 'Rest Password'.tr,
          ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){
          if(state is ResetPasswordSuccessState)
            {
              showToast(title: 'Success'.tr, description: "password updated success".tr,context: context, state: MotionState.success);
              navigateAndFinish(context, const LoginScreen());
            }
        },
        builder: (context , state ){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    Text('Please Enter New Password'.tr,
                        style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                      context:context,
                      controller: passwordController1,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty!'.tr;
                        }
                        if(value.length<8)
                          {
                            return 'Password must be at least 8 characters!'.tr;
                          }
                        return null;
                      },
                      label: 'New Password'.tr,
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: LoginCubit.get(context).prefixIcon,
                      isPassword: LoginCubit.get(context).isPassword,
                      prefixPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 15.0,),
                    defaultFormField(
                      context:context,
                      controller: passwordController2,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty!'.tr;
                        }
                        if(value != passwordController1.text)
                          {
                            return 'Password does not match!'.tr;
                          }
                        return null;
                      },
                      label: 'Retype password'.tr,
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
                      text: "Next".tr,
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          LoginCubit.get(context).userResetPassword(email: email, newPassword: passwordController1.text);
                        }
                      },
                      context: context,
                      color: Theme.of(context).primaryColor,
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
