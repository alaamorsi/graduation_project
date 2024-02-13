import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/second_screen.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'login_screen.dart';

class studenScreen extends StatefulWidget {
  @override
  _studenScreenState createState() => _studenScreenState();
}

class _studenScreenState extends State<studenScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController namecontrol = TextEditingController();
  TextEditingController  emillecontrol = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Color primary = Theme.of(context).primaryColor;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.0,),
                    InkWell(
                      onTap: (){navigateAndFinish(context, SecondScreen());},
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded,
                                color: primary,size: 35.0,
                          ),
                          Text("سجل الدخول",
                            style: TextStyle(color: primary,fontSize: 25.0,fontWeight: FontWeight.bold),)
                        ]
                      ),
                    ),
                    SizedBox(height: 70.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "حساب طالب",
                          style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,
                              color: primary),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'سجل الأن لتستمتع بخدماتنا الرائعة',
                          style:TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    defaultFormField(
                        controller: namecontrol,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل الاسم';
                          }
                        },
                        label: 'الاسم',
                        suffixIcon: Icons.account_box_rounded),
                    SizedBox(height: 10.0),
                    defaultFormField(
                        controller: emillecontrol,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل البريد الالكتروني الصحيح';
                          }
                        },
                        label: 'البريد الإلكتروني',
                        suffixIcon: Icons.email_outlined),
                    SizedBox(height: 10.0),
                    defaultFormField(
                      controller: password,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return ' رجاءً ادخل كلمة المرور بشكل صحيح';
                        }
                      },
                      label: 'كلمة المرور',
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: LoginCubit.get(context).prefixIcon,
                      isPassword: LoginCubit.get(context).isPassword,
                      prefixPressed: () {
                        LoginCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    SizedBox(height: 10.0),
                    //شروط الاستخدام
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'شروط الاستخدام',
                            style:Theme.of(context).textTheme.labelSmall,textAlign:TextAlign.right),
                        Checkbox(
                          side: BorderSide(color: mode?Colors.black:Colors.white),
                          value: LoginCubit.get(context).acceptCondition,
                          onChanged: (value) {
                            LoginCubit.get(context).changeAcceptConditions();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    //login button
                    usedButton(
                      atEnd: false,
                      text: "إنشاء",
                      onPressed: () {if (_formkey.currentState!.validate()) {
                        print("successful");
                        return;
                      } else {
                        print("UnSuccessfull");}
                      },
                      context: context,
                      color: Theme.of(context).canvasColor,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("سجل الدخول",
                              style: TextStyle(color: primary,fontSize:15.0,fontWeight: FontWeight.bold)),
                        ),
                        Text(" لديك حساب بالفعل ؟",
                          style:TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ]
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
