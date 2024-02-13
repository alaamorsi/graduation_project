import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/modules/login/second_screen.dart';
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'تسجيل الدخول',
                          style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
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
                        controller: confirmpassword,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل البريد الالكتروني الصحيح';
                          }
                        },
                        label: 'البريد الإلكتروني',
                        suffixIcon: Icons.email_outlined),
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
                      paddingSize: 10.0,
                      text: "تسجيل الدخول",
                      onPressed: () {if (_formkey.currentState!.validate()) {
                          print("successful");
                          navigateAndFinish(context, StudentLayout());
                          return;
                        } else {
                        print("UnSuccessfull");}
                      },
                      context: context,
                      color: Theme.of(context).canvasColor,
                    ),
                    SizedBox(height: 10.0),
                    //didn't have an account?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen()));
                          },
                          child: Text("انشاء حساب",
                              style: TextStyle(color: Theme.of(context).primaryColor,fontSize:15.0,fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "ليس لديك حساب ؟",
                          style: TextStyle(color: Colors.grey,fontSize: 14.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'أو',
                          style:
                          TextStyle(fontSize: 15.0,color: Theme.of(context).canvasColor),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            width: double.infinity,
                            color: Theme.of(context).iconTheme.color,
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
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                            foregroundImage: AssetImage("Assets/G.jpg"),
                            child: InkWell(onTap: (){},),
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
    );
  }
}