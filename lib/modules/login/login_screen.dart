import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/secnd_screen.dart';
import 'package:graduation_project/my_flutter_app_icons.dart';
import '../../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
                          controller: confirmpassword,
                          type: TextInputType.text,
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
                                        builder: (context) => secend_screen()));
                              },
                              child: Text("انشاء حساب",
                                  style: TextStyle(color: Colors.blueAccent)),
                            ),
                            Text(
                              "ليس لديك حساب ؟",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'أو التسجيل عن طريق',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                MyFlutterApp.google_plus_g,
                                size: 50,
                                color: Colors.red,
                              )),
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
