import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/register/Confirm_Screen.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/modules/register/second_screen.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TextController to read text entered in text field
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController1 = TextEditingController();
    TextEditingController nameController2 = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if(state is RegisterSuccessState)
        {
          RegisterCubit.get(context).sendConfirm(email: emailController.text);
          navigateTo(context, ConfirmScreen(email: emailController.text,));
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0,),
                    InkWell(
                      onTap: (){navigateAndFinish(context, const SecondScreen());},
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded,
                            color: theme.primaryColor,size: 36.0,
                          ),
                          Text("login",
                            style: font.copyWith(color: theme.primaryColor,fontSize: 27.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 70.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "teacher account",
                          style:font.copyWith(fontSize: 25.0,fontWeight: FontWeight.bold,
                              color: theme.primaryColor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register now to enjoy our great services',
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
                            return 'This field cannot be empty !';
                          }
                          return null;
                        },
                        label: 'First name',
                        suffixIcon: Icons.account_box_rounded),
                    const SizedBox(height: 10.0),
                    defaultFormField(
                        controller: nameController2,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty !';
                          }
                          return null;
                        },
                        label: 'last name',
                        suffixIcon: Icons.account_box_rounded),
                    const SizedBox(height: 10.0),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'This field cannot be empty !';
                          }
                          else if (!cubit.checkForNumbers(value))
                          {
                            return 'Invalid Email !';
                          }
                          return null;
                        },
                        label: 'Email address',
                        suffixIcon: Icons.email_outlined),
                    const SizedBox(height: 10.0),
                    defaultFormField(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty || value.length<8) {
                          return 'Password must be at least 8 characters !';
                        }
                        return null;
                      },
                      label: 'password',
                      suffixIcon: Icons.lock_outline,
                      prefixIcon: cubit.prefixIcon,
                      isPassword: cubit.isPassword,
                      prefixPressed: () {
                        cubit.changePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          side: BorderSide(color: theme.iconTheme.color!),
                          value: cubit.acceptCondition,
                          onChanged: (value) {
                            cubit.changeAcceptConditions();
                          },
                        ),
                        Text(
                            'terms of use',
                            style:Theme.of(context).textTheme.labelSmall,textAlign:TextAlign.right),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    //login button
                    usedButton(
                      atEnd: false,
                      isLoading: cubit.isLoading,
                      text: "create",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.userRegister(firstName: nameController1.text, lastName: nameController2.text, email: emailController.text, password: passwordController.text, role: 'student');
                        }
                      },
                      context: context,
                      color: theme.cardColor,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account already ?",
                          style:
                          font.copyWith(color: Colors.grey, fontSize: 12.0),
                        ),
                        TextButton(
                          onPressed: () {
                            navigateTo(context, const LoginScreen());
                          },
                          child: Text("login now",
                              style: font.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold)),
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
