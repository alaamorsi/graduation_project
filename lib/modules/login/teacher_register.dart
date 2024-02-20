import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/second_screen.dart';
import 'package:graduation_project/shared/constant.dart';
import '../../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'login_screen.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override

  TeacherScreenState createState() => TeacherScreenState();
}

class TeacherScreenState extends State<TeacherScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var theme = Theme.of(context);
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
                    const SizedBox(height: 10.0,),
                    InkWell(
                      onTap: (){navigateAndFinish(context, const SecondScreen());},
                      child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_rounded,
                              color:theme.canvasColor,size: 35.0,
                            ),
                            Text("سجل الدخول",
                              style: font.copyWith(color: theme.canvasColor,fontSize: 25.0,fontWeight: FontWeight.bold),)
                          ]
                      ),
                    ),
                    const SizedBox(height: 50.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'حساب مدرس',
                          style:font.copyWith(fontSize: 25.0,fontWeight: FontWeight.bold,
                              color: theme.canvasColor),
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
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل الاسم';
                          }
                          return null;
                        },
                        label: 'الاسم',
                        suffixIcon: Icons.account_box_rounded),
                    const SizedBox(height: 10.0),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل رقم الموبايل';
                          }
                          return null;
                        },
                        label: 'رقم الموبايل',
                        suffixIcon: Icons.phone),
                    const SizedBox(height: 10.0),
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
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(height: 10.0),
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
                          side: BorderSide(color: theme.iconTheme.color!),
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
                      text: "إنشاء",
                      onPressed: () {if (formKey.currentState!.validate()) {
                        return;
                      } else {

                      }
                      },
                      context: context,
                      color: theme.cardColor,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: Text("سجل الدخول",
                              style: font.copyWith(color:theme.cardColor,fontSize:15.0,fontWeight: FontWeight.bold)),
                        ),
                        Text(" لديك حساب بالفعل ؟",
                          style:font.copyWith(fontSize: 14.0,color:Colors.grey),
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
