import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/secnd_screen.dart';
import 'package:graduation_project/my_flutter_app_icons.dart';
import '../../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'login_screen.dart';

class teacherScreen extends StatefulWidget {
  @override
  _teacherScreenState createState() => _teacherScreenState();
}

class _teacherScreenState extends State<teacherScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController namecontrol = TextEditingController();
  TextEditingController  emillecontrol = TextEditingController();
  TextEditingController  phoneecontrol = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      defaultFormField(
                          controller: namecontrol,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجاءً ادخل الاسم';
                            }
                          },
                          label: 'الاسم',
                          prefixIcon: Icons.account_box_rounded),
                      defaultFormField(
                          controller: phoneecontrol,
                          type: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجاءً ادخل رقم الموبايل';
                            }
                          },
                          label: 'رقم الموبايل',
                          prefixIcon: Icons.phone),
                      defaultFormField(
                          controller: emillecontrol,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجاءً ادخل البريد الالكتروني الصحيح';
                            }
                          },
                          label: 'البريد الإلكتروني',
                          prefixIcon: Icons.email_outlined),
                      defaultFormField(
                        controller: password,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' رجاءً ادخل كلمة المرور بشكل صحيح';
                          }
                        },
                        label: 'كلمة المرور',
                        // prefixIcon: Icons.lock_outline,
                        prefixIcon: LoginCubit.get(context).prefixIcon,
                        isPassword: LoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'شروط استخدام هذا التطبيق',
                            style:
                            TextStyle(fontSize: 15.0, color: Colors.grey),
                          ),
                          Checkbox(
                            value: LoginCubit.get(context).acceptCondition,
                            onChanged: (value) {
                              LoginCubit.get(context).changeAcceptConditions();
                            },
                          ),
                        ],
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  print("successful");

                                  return;
                                } else {
                                  print("UnSuccessfull");
                                }
                              },
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 2.0,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 150),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text("تسجيل الدخول",
                                  style: TextStyle(color: Colors.blueAccent)),
                            ),
                            Text(
                              " لديك حساب بالفعل ؟",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
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
