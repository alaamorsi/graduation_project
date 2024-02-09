import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';
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
  TextEditingController emillecontrol = TextEditingController();
  TextEditingController phoneecontrol = TextEditingController();

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
                            'أنشئ حساب مدرس',
                            style:Theme.of(context).textTheme.titleMedium,
                          ),
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
                        prefixIcon: Icons.account_box_rounded),
                    SizedBox(height: 10.0),
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
                        prefixIcon: Icons.email_outlined),
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
                      text: "إنشاء",
                      onPressed: () {if (_formkey.currentState!.validate()) {
                        print("successful");
                        return;
                      } else {
                        print("UnSuccessfull");}
                      },
                      context: context,
                      color: Colors.red.shade900,
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text("سجل الدخول",
                              style: TextStyle(color: Colors.red.shade900,fontSize:15.0,fontWeight: FontWeight.bold)),
                        ),
                        Text(" لديك حساب بالفعل ؟",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0),
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
