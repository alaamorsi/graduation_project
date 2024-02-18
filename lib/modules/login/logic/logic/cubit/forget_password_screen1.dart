import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/logic/logic/cubit/forget_password_screen2.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:graduation_project/shared/constant.dart';

class ForgetPasswordScreen1 extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('هل نسيت كلمة السر؟'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight/2,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('Assets/forgetpassword.png',),fit: BoxFit.fitWidth),
                  ),
                ),
                Text('رجاءاً ادخل البريد الإلكتروني للحساب الخاص بك', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                Text('سوف نرسل الي البريد الإلكتروني الخاص بك رمز التحقق', style: TextStyle(fontSize: 16.0,),),
                SizedBox(height: 20.0,),
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
                SizedBox(height: 20.0,),
                Container(
                  width: double.infinity,
                    height: 50.0,
                    child: ElevatedButton(onPressed: (){
                      if(formKey.currentState!.validate())
                      navigateTo(context, ForgetPasswordScreen2());
                    }, child: Text('التالي'))),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
