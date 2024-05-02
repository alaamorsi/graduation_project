import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../login/cubit/cubit.dart';
import '../login/cubit/states.dart';
import 'forget_password_screen2.dart';

class ForgetPasswordScreen1 extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ForgetPasswordScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context , state){
        if (state is SendResetCodeSuccessState)
          {
            showToast(title: 'Info'.tr, description: "we sent you verification code ,check your gmail!".tr,context: context, state: MotionState.info);
            navigateTo(context, ForgetPasswordScreen2(email: emailController.text,));
          }
        else if (state is SendResetCodeErrorState)
        {
          showToast(title: 'Error'.tr, description: "email not found".tr,context: context, state: MotionState.error);
        }
      },
      builder: (context , state){
        var cubit = LoginCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: 'Forgot password?'.tr,
          ),
          body: Padding(
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
                    Text('Please enter your account email'.tr,
                        style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                        context: context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty!'.tr;
                          }
                          else if (!cubit.checkForNumbers(value))
                            {
                              return 'Invalid Email!'.tr;
                            }
                          return null;
                        },
                        label: 'email address'.tr,
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(height: 20.0,),
                    usedButton(
                      atEnd: false,
                      paddingSize: 10.0,
                      isLoading: LoginCubit.get(context).isLoading,
                      text: "Next".tr,
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          cubit.sendResetCode(email: emailController.text, reset: true);
                        }
                      },
                      context: context,
                      color: Theme.of(context).primaryColor,
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
