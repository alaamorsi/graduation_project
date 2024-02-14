import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/constant.dart';

import '../shared/cache_helper.dart';
import '../shared/components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_outlined)),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Text("الأعدادات",style: Theme.of(context).textTheme.titleLarge,),
            ),
          ),
          body: Padding(
            padding:  EdgeInsets.all(30.0),
            child: Column(
                children: [
                  Row(

                      children: [
                        Spacer(),
                        Text("لغة التطبيق",style: Theme.of(context).textTheme.titleSmall,),
                      ]
                  ),
                  Row(
                      children: [
                        DropdownMenu(
                            width: 300.0,
                            enableSearch: false,
                            label: Text("اللغة",style: Theme.of(context).textTheme.titleMedium,),
                            initialSelection: CacheHelper.getData(key: 'ln')??"عربي",
                            dropdownMenuEntries:  <DropdownMenuEntry<String>>[
                              DropdownMenuEntry(value: "English", label: "English",
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color),
                                ),
                              ),
                              DropdownMenuEntry(value: "Arabic", label: "عربي",
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color),
                                ),
                              ),
                            ],
                          onSelected: (language){
                            switch (language) {
                              case "Arabic":
                                appCubit.changeAppMode("Arabic");
                                break;
                              case "English":
                                appCubit.changeAppMode("English");
                                break;
                            }
                          },
                          inputDecorationTheme: InputDecorationTheme(
                            floatingLabelStyle: Theme.of(context).textTheme.titleSmall,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: mode?Colors.black:Colors.white,
                                  width: 2.0
                              ),
                            ),
                            enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: mode?Colors.black:Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          textStyle: Theme.of(context).textTheme.titleSmall,
                          menuStyle: MenuStyle(
                            backgroundColor: MaterialStateProperty.all(mode?Colors.white:Colors.black),
                            side: MaterialStateProperty.all(
                                BorderSide(color: mode?Colors.black:Colors.white),
                            ),
                          ),
                        ),
                      ]
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                      children: [
                        const Spacer(),
                        Text("مظهر التطبيق",style: Theme.of(context).textTheme.titleSmall,),
                      ]
                  ),
                  Row(
                    children: [
                      myDropDownMenu(
                          context: context,
                          textLabel: "المظهر",
                          initialSelectionText: CacheHelper.getData(key: 'tm')??"الخاص بالنظام",
                          chooses: [
                            DropdownMenuEntry(value: "Light", label: "فاتح",
                              leadingIcon: Icon(Icons.light_mode,color: Theme.of(context).iconTheme.color),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                                foregroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color),
                              ),
                            ),
                            DropdownMenuEntry(value: "Dark", label: "داكن",
                              leadingIcon: Icon(Icons.dark_mode,color: Theme.of(context).iconTheme.color),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                                foregroundColor: MaterialStateProperty.all(Theme.of(context).iconTheme.color),
                              ),
                            ),
                          ],
                          onSelect: (color){
                            switch (color) {
                              case "Light":
                                appCubit.changeAppMode("Light");
                                break;
                              case "Dark":
                                appCubit.changeAppMode("Dark");
                                break;
                            }
                          }
                      ),
                    ]
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
}