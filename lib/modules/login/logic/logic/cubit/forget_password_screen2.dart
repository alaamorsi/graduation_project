import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/login/logic/logic/cubit/reset_password_screen.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:graduation_project/shared/constant.dart';

class ForgetPasswordScreen2 extends StatelessWidget {
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('هل نسيت كلمة السر؟'),
      ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){},
        builder: (context , state){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight/2,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage('Assets/check_email.png',),fit: BoxFit.fitWidth),
                      ),
                    ),
                    Text('رجاءاً ادخل رمز التحقق الذي تم ارساله', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    Text('لفد ارسلنا الي البريد الإلكتروني الخاص بك رمز التحقق', style: TextStyle(fontSize: 16.0,),),
                    SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: codeController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'رجاءً ادخل رمز التحقق الصحيح';
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
                    SizedBox(height: 20.0,),
                    Container(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(onPressed: (){
                          if(formKey.currentState!.validate())
                            navigateTo(context, ResetPasswordScreen());
                        }, child: Text('التالي'))),

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
