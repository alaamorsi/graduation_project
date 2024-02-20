import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/student_layout.dart';
import 'package:graduation_project/modules/login/forget_password_screen1.dart';
import 'package:graduation_project/modules/login/second_screen.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تسجيل الدخول',
                            style: font.copyWith(fontSize: 25.0,fontWeight: FontWeight.bold,
                            color: Theme.of(context).canvasColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'سجل الأن لتستمتع بخدماتنا الرائعة',
                            style:font.copyWith(fontSize: 13.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                          controller: confPasswordController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'رجاءً ادخل البريد الالكتروني الصحيح';
                            }
                            return null;
                          },
                          label: 'البريد الإلكتروني',
                          suffixIcon: Icons.email_outlined),
                      const SizedBox(height: 20.0,),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' رجاءً ادخل كلمة المرور بشكل صحيح';
                          }
                          return null;
                        },
                        label: 'كلمة المرور',
                        suffixIcon: Icons.lock_outline,
                        prefixIcon: LoginCubit.get(context).prefixIcon,
                        isPassword: LoginCubit.get(context).isPassword,
                        prefixPressed: () {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //شروط الاستخدام
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'شروط الاستخدام',
                            style:Theme.of(context).textTheme.labelSmall,textAlign:TextAlign.right),
                          Checkbox(
                            side: BorderSide(color: Theme.of(context).iconTheme.color!),
                            value: LoginCubit.get(context).acceptCondition,
                            onChanged: (value) {
                              LoginCubit.get(context).changeAcceptConditions();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      //login button
                      usedButton(
                        atEnd: false,
                        paddingSize: 10.0,
                        text: "تسجيل الدخول",
                        onPressed: () {if (formKey.currentState!.validate()) {
                            // print("successful");
                            navigateAndFinish(context, const StudentLayout());
                            return;
                          } else {
                          // print("UnSuccessful");
                        }
                        },
                        context: context,
                        color: Theme.of(context).canvasColor,
                      ),
                      const SizedBox(height: 10.0),
                      //didn't have an account?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              navigateTo(context, const SecondScreen());
                            },
                            child: Text("انشاء حساب",
                                style: font.copyWith(color: Theme.of(context).canvasColor,fontSize:15.0,fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            "ليس لديك حساب ؟",
                            style: font.copyWith(color: Colors.grey,fontSize: 14.0),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              navigateTo(context, ForgetPasswordScreen1());
                            },
                            child: Text("هل نسيت كلمة السر؟",
                                style: font.copyWith(color: Theme.of(context).canvasColor,fontSize:15.0,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                          const SizedBox(width: 5.0,),
                          Text(
                            'أو',
                            style:
                            font.copyWith(fontSize: 15.0,color: Theme.of(context).canvasColor),
                          ),
                          const SizedBox(width: 5.0,),
                          Expanded(
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      //google logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20.0,
                              foregroundImage: const AssetImage("Assets/G.jpg"),
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
      ),
    );
  }
}