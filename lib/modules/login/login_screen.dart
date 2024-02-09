import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/modules/login/secnd_screen.dart';
import 'package:graduation_project/shared/constant.dart';
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
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 100.0,
                      child: Image(image: mode?AssetImage('Assets/logo1.png'):AssetImage('Assets/logo2.png'),),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'تسجيل الدخول',
                            style:Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
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
                    SizedBox(height: 20.0,),
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
                      text: "تسجيل الدخول",
                      onPressed: () {if (_formkey.currentState!.validate()) {
                          print("successful");
                          navigateAndFinish(context, StudentLayout());
                          return;
                        } else {
                        print("UnSuccessfull");}
                      },
                      context: context,
                      color: Colors.red.shade900,
                    ),
                    SizedBox(height: 10.0),
                    //didn't have an account?
                    Row(
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
                              style: TextStyle(color: Colors.red.shade900,fontSize:15.0,fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "ليس لديك حساب ؟",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Text(
                          'أو التسجيل عن طريق',
                          style:
                          TextStyle(fontSize: 15.0, color: Colors.red),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    //google logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.red.shade900,),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.g_mobiledata,
                                  size: 35.0,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
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