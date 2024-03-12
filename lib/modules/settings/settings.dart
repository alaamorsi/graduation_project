import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/registeration/login/login_screen.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
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
          appBar: secondAppbar(context: context, title:"Settings",),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  // Row(children: [
                  //   myDropDownMenu(
                  //     context: context,
                  //     title: "اللغة",
                  //     initialSelectionText: langTitle,
                  //     chooses: <DropdownMenuEntry<String>>[
                  //       DropdownMenuEntry(
                  //         value: "en",
                  //         label: "English",
                  //         style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all(
                  //               Theme.of(context).scaffoldBackgroundColor),
                  //           foregroundColor: MaterialStateProperty.all(
                  //               Theme.of(context).iconTheme.color),
                  //         ),
                  //       ),
                  //       DropdownMenuEntry(
                  //         value: "ar",
                  //         label: "عربي",
                  //         style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all(
                  //               Theme.of(context).scaffoldBackgroundColor),
                  //           foregroundColor: MaterialStateProperty.all(
                  //               Theme.of(context).iconTheme.color),
                  //         ),
                  //       ),
                  //     ],
                  //     onSelect: (language) {
                  //       switch (language) {
                  //         case "ar":
                  //           appCubit.changeAppLanguage(context,'ar');
                  //           break;
                  //         case "en":
                  //           appCubit.changeAppLanguage(context,'en');
                  //           break;
                  //       }
                  //     }),
                  // ]),
                  //app language
                  InkWell(
                    onTap: (){
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
                        Text("language",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
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
                        Text("Theme",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
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
                      Text("Notifications",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
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
                    onTap: (){
                      StudentCubit.get(context).clearCache();
                      navigateAndFinish(context, const LoginScreen());
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
                        Text("Logout",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),)
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
