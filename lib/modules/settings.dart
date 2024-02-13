import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/constant.dart';

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
                            initialSelection: "عربي",
                            onSelected: (lang){

                            },
                            dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                              DropdownMenuEntry(value: "English", label: "English"),
                              DropdownMenuEntry(value: "عربي", label: "عربي"),
                            ],
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
                        DropdownMenu(
                          width: 300.0,
                          enableSearch: false,
                          label: Text("المظهر",style: Theme.of(context).textTheme.titleMedium,),
                          initialSelection: "تلقائي",
                          dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                            DropdownMenuEntry(value: "تلقائي", label: "تلقائي"),
                            DropdownMenuEntry(value: "فاتح", label: "فاتح"),
                            DropdownMenuEntry(value: "غامق", label: "غامق"),
                          ],
                          onSelected: (color){
                            if (color == "فاتح")
                            {
                              appCubit.changeAppMode("فاتح");
                            }
                            else if (color == "غامق")
                            {
                              appCubit.changeAppMode("غامق");
                            }
                            else
                            {
                              appCubit.changeAppMode("تلقائي");
                            }
                          },
                          inputDecorationTheme: InputDecorationTheme(
                            labelStyle: Theme.of(context).textTheme.titleSmall,
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
                ]
            ),
          ),
        );
      },
    );
  }
}
