import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/reset/forget_password_screen2.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

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
            navigateTo(context, ForgetPasswordScreen2(email: emailController.text,));
          }
      },
      builder: (context , state){
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('هل نسيت كلمة السر؟'),
          ),
          body: Padding(
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
                    Text('رجاءاً ادخل البريد الإلكتروني للحساب الخاص بك',
                        style: font.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl),
                    Text('سوف نرسل الي البريد الإلكتروني الخاص بك رمز التحقق',
                      style: font.copyWith(fontSize: 16.0,),textDirection: TextDirection.rtl,),
                    const SizedBox(height: 20.0,),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return '!'' لا يمكن ترك هذه الخانة فارغة';
                          }
                          else if (!cubit.checkForNumbers(value))
                            {
                              return '!'' البريد الإلكتروني غير صالح';
                            }
                          return null;
                        },
                        label: 'البريد الإلكتروني',
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(height: 20.0,),
                    usedButton(
                      atEnd: false,
                      paddingSize: 10.0,
                      isLoading: LoginCubit.get(context).isLoading,
                      text: "التالي",
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          cubit.sendResetCode(email: emailController.text, reset: true);
                        }
                      },
                      context: context,
                      color: Theme.of(context).canvasColor,
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
