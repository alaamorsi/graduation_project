import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/shared/components.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Educa',
                              style: TextStyle(
                                fontSize: 50.0,
                                color: Colors.blue,
                              ),
                              children: <TextSpan>[
                            TextSpan(
                                text: 'tiona',
                                style: TextStyle(
                                  fontSize: 50.0,
                                  color: Colors.yellow,
                                )),
                          ])),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجاءً ادخل البريد الالكتروني الصحيح';
                            }
                            return null;
                          },
                          label: 'البريد الإلكتروني',
                          prefixIcon: Icons.email_outlined),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل كلمة المرور الصحيحة';
                          }
                          return null;
                        },
                        suffixIcon: LoginCubit.get(context).suffixIcon,
                        label: 'كلمة المرور',
                        prefixIcon: Icons.lock_outline,
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('شروط استخدام هذا التطبيق',style: TextStyle(fontSize: 15.0),),
                          Checkbox(
                            value: LoginCubit.get(context).acceptCondition,
                            onChanged: (value) {
                              LoginCubit.get(context).changeAcceptConditions();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                          width: double.infinity,
                          height: 55.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                              color: Colors.blue),
                          child: ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                  {
                                  }
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style:
                                    TextStyle(fontSize: 20.0, color: Colors.white),
                              ))),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){}, child: Text('إنشاء حساب',style: TextStyle(fontSize: 15.0),),),
                          Text('ليس لديك حساب ؟',style: TextStyle(fontSize: 15.0),),
                        ],
                      ),
                      SizedBox(height: 40.0,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 2.0,),
                          Text('أو التسجيل عن طريق',style: TextStyle(fontSize: 20.0),),
                          SizedBox(width: 2.0,),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
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
      ),
    );
  }
}
