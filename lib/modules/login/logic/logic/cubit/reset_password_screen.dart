import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:graduation_project/shared/constant.dart';

class ResetPasswordScreen extends StatelessWidget {
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إعادة تعيين كلمة السر'),
      ),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context , state){},
        builder: (context , state ){
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
                        image: DecorationImage(image: AssetImage('Assets/forgetpassword.png',),fit: BoxFit.fitWidth),
                      ),
                    ),
                    Text('رجاءاً ادخل كلمة السر الجديدة', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20.0,),
                    defaultFormField(
                      controller: passwordController1,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return ' رجاءً ادخل كلمة المرور بشكل صحيح';
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
                    SizedBox(height: 15.0,),
                    defaultFormField(
                      controller: passwordController2,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty || value != passwordController1.text) {
                          return ' رجاءً ادخل كلمة المرور بشكل صحيح';
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
                    SizedBox(height: 20.0,),
                    Container(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(onPressed: (){
                          if(formKey.currentState!.validate())
                            navigateTo(context, LoginScreen());
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
