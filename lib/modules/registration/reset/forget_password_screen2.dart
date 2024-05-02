import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/registration/reset/reset_password_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';

class ForgetPasswordScreen2 extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;
  ForgetPasswordScreen2({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondAppbar(
            context: context,
            title: 'Forgot password?'.tr,
          ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){
          if (state is ValidateResetPasswordSuccessState)
            {
              showToast(title: 'Success'.tr, description: "code is correct".tr,context: context, state: MotionState.success);
              navigateTo(context, ResetPasswordScreen(email: email,));
            }
          else if (state is ValidateResetPasswordErrorState)
          {
            showToast(title: 'Error'.tr, description: "code is not correct".tr,context: context, state: MotionState.error);
          }
        },
        builder: (context , state){
          var theme = Theme.of(context);
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
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: screenWidth*3/4,
                        height: screenWidth*3/4,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('Assets/check_email.png',),fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    Text("verification message".tr,
                        style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                      context:context,
                      controller: codeController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be empty!'.tr;
                        }
                        return null;
                      },
                      label: 'Verification Code'.tr,
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
                          LoginCubit.get(context).validateResetCode(email: email, code: codeController.text);
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
