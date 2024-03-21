import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../layout/student/student_cubit/student_cubit.dart';
import '../registration/login/login_screen.dart';
import 'theme_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(context: context, title:"Settings".tr,),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  //app language
                  InkWell(
                    onTap: (){
                      appCubit.changeAppLanguage();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: Icon(Icons.language_outlined,size: 25,color:theme.primaryColor),
                        ),
                        const SizedBox(width: 20,),
                        Text("language".tr,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 18,color:theme.primaryColor),
                      ],
                    ),
                  ),
                  newDivider(),
                  //app theme
                  InkWell(
                    onTap: (){
                      navigateTo(context, const ThemeScreen());
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: Icon(Icons.imagesearch_roller_rounded,size: 25,color:theme.primaryColor),
                        ),
                        const SizedBox(width: 20,),
                        Text("Theme".tr,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios_outlined,size: 18,color:theme.primaryColor),
                      ],
                    ),
                  ),
                  newDivider(),
                  //notifications
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child:Icon(Icons.notifications,size: 25,color:theme.primaryColor,),
                      ),
                      const SizedBox(width: 20,),
                      Text("Notifications".tr,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                      const Spacer(),
                      Switch(
                        value: notification,
                        inactiveThumbColor: Colors.grey,
                        activeColor: theme.primaryColor,
                        onChanged: (value) {
                          appCubit.changeNotificationState();
                        }),
                    ],
                  ),
                  newDivider(),
                  //logout
                  InkWell(
                    onTap: ()async{
                      int? response = await StudentCubit.get(context).logOut(CacheHelper.getData(key: 'refreshToken'));
                      if(response == 200){
                        Get.offAll( const LoginScreen());
                      }
                      else{
                        print(response.toString());
                        showToast(title: 'Error'.tr, description: "Something went wrong".tr,context: context, state: MotionState.error);
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child:const Icon(Icons.input_outlined,size: 20,color: Colors.red,),
                        ),
                        const SizedBox(width: 20,),
                        Text("Logout".tr,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),)
                      ],
                    ),
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
}
