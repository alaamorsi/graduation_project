import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/registration/login/login_screen.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:hexcolor/hexcolor.dart';

class MakeYourSettingScreen extends StatelessWidget {
  const MakeYourSettingScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            toolbarHeight: 90.0,
            title: Text("Make your settings".tr,
              style: font.copyWith(fontSize: 25.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth*.02),
              child: Column(
                  children: [
                    Row(
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
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: InkWell(
                            onTap: (){
                              appCubit.changeAppLanguage('ar');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 60,
                              width: screenWidth/2.5,
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                              ),
                              child:Text("العربية",textAlign: TextAlign.center,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: InkWell(
                            onTap: (){
                              appCubit.changeAppLanguage('en');
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 60,
                              width: screenWidth/2.5,
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                              ),
                              child:Text("English",textAlign: TextAlign.center,style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                            ),
                          ),
                        ),
                      ],
                    ),
                    newDivider(),
                    //theme
                    Row(
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
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Wrap(
                      children: [
                        themeItem(title: "Orange (Safety)".tr, icon: Icons.headset, cardColor: HexColor("#FF4500"), tap: (){appCubit.changeTheme(1);}),
                        themeItem(title: "Green (Natural)".tr, icon: Icons.eco_rounded,cardColor: HexColor("#056608"), tap: (){appCubit.changeTheme(2);}),
                        themeItem(title: "Blue (Freedom)".tr, icon: Icons.flight_takeoff_rounded,cardColor: HexColor("#1589FF"), tap: (){appCubit.changeTheme(3);}),
                        themeItem(title: "Purple (Power)".tr, icon: Icons.yard_rounded,cardColor: HexColor("#9933ff"), tap: (){appCubit.changeTheme(4);}),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Get.to(const LoginScreen());
                      },
                      child: Padding(padding: const EdgeInsets.only(right:10.0),
                        child:Container(
                            padding: const EdgeInsets.all(9),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                            ),
                            child: Text("login".tr,style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),)
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        );
      },
    );
  }
}