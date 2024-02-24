import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/register/Confirm_Screen.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/second_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../shared/component/constant.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  StudentScreenState createState() => StudentScreenState();
}

class StudentScreenState extends State<StudentScreen> {
  late String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState)
            {
              RegisterCubit.get(context).sendConfirm(email: emailController.text);
              navigateTo(context, ConfirmScreen(email: emailController.text,));
            }
        },
        builder: (context, state) {
          var theme = Theme.of(context);
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10.0,),
                      InkWell(
                        onTap: (){navigateAndFinish(context, const SecondScreen());},
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios_rounded,
                                  color: theme.canvasColor,size: 35.0,
                            ),
                            Text("سجل الدخول",
                              style: font.copyWith(color: theme.canvasColor,fontSize: 25.0,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 70.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "حساب طالب",
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
                            style: font.copyWith(fontSize: 13.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                          controller: nameController1,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return '!'' لا يمكن ترك هذه الخانة فارغة';
                            }
                            return null;
                          },
                          label: 'الاسم الاول',
                          suffixIcon: Icons.account_box_rounded),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: nameController2,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return '!'' لا يمكن ترك هذه الخانة فارغة';
                            }
                            return null;
                          },
                          label: 'الاسم الاخير',
                          suffixIcon: Icons.account_box_rounded),
                      const SizedBox(height: 10.0),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return '!'' لا يمكن ترك هذه الخانة فارغة';
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
                          if (value!.isEmpty || value.length<8) {
                            return '!'' كلمة المرور يجب ان لا تقل عن ٨ احرف';
                          }
                          return null;
                        },
                        label: 'كلمة المرور',
                        suffixIcon: Icons.lock_outline,
                        prefixIcon: cubit.prefixIcon,
                        isPassword: cubit.isPassword,
                        prefixPressed: () {
                          cubit.changePasswordVisibility();
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
                            value: cubit.acceptCondition,
                            onChanged: (value) {
                              cubit.changeAcceptConditions();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      //login button
                      usedButton(
                        atEnd: false,
                        isLoading: cubit.isLoading,
                        text: "إنشاء",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print(emailController.text);
                            print(nameController1.text);
                            print(nameController2.text);
                            print(passwordController.text);
                          cubit.userRegister(firstName: nameController1.text, lastName: nameController2.text, email: emailController.text, password: passwordController.text, role: 0);
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
                              navigateAndFinish(context,const LoginScreen());
                            },
                            child: Text("سجل الدخول",
                                style: font.copyWith(color: theme.canvasColor,fontSize:15.0,fontWeight: FontWeight.bold)),
                          ),
                          Text(" لديك حساب بالفعل ؟",
                            style: font.copyWith(fontSize: 14.0, color: Colors.grey),
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
      ),
    );
  }
}
