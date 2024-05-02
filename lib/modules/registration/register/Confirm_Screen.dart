import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ConfirmScreen extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String email;
  ConfirmScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context , state){
        if(state is CheckCodeConfirmSuccessState)
        {
          showToast(title: 'Success'.tr, description: "your email has been confirmed".tr,context: context, state: MotionState.success);
          navigateTo(context, const LoginScreen());
        }
        else if (state is CheckCodeConfirmErrorState){
          showToast(title: 'Error'.tr, description: "code is not correct".tr,context: context, state: MotionState.error);
        }
      },
      builder: (context , state){
        var cubit = RegisterCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title:'Email confirm'.tr),
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
                          image: DecorationImage(image: AssetImage('Assets/check_email.png',),fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Text("verification message".tr,
                        style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                      context: context,
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
                      prefixIcon: cubit.prefixIcon,
                      isPassword: cubit.isPassword,
                      prefixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 20.0,),
                    usedButton(
                      atEnd: false,
                      paddingSize: 10.0,
                      isLoading: cubit.isLoading,
                      text: "Next".tr,
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          cubit.validateCodeConfirm(email: email, code: codeController.text);
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

