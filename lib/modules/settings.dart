import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../shared/network/cache_helper.dart';
import 'package:graduation_project/shared/component/components.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: defaultAppBar(
            context: context,
            leadingIcon: Icons.arrow_back_ios_outlined,
            leadingFunction: () {
              Navigator.pop(context);
            },
            title: Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Text(
                "الأعدادات",
                style: font.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              Row(children: [
                const Spacer(),
                Text(
                  "لغة التطبيق",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ]),
              Row(children: [
                myDropDownMenu(
                    context: context,
                    title: "اللغة",
                    initialSelectionText: langTitle,
                    chooses: <DropdownMenuEntry<String>>[
                      DropdownMenuEntry(
                        value: "en",
                        label: "English",
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).scaffoldBackgroundColor),
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).iconTheme.color),
                        ),
                      ),
                      DropdownMenuEntry(
                        value: "ar",
                        label: "عربي",
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).scaffoldBackgroundColor),
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).iconTheme.color),
                        ),
                      ),
                    ],
                    onSelect: (language) {
                      switch (language) {
                        case "ar":
                          appCubit.changeAppLanguage("ar");
                          break;
                        case "en":
                          appCubit.changeAppLanguage("en");
                          break;
                      }
                    }),
              ]),
              const SizedBox(height: 30.0),
              //notifications setting
              Container(
                height: 65.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  border: Border.all(
                      color: Theme.of(context).iconTheme.color!, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(children: [
                  Switch(
                      value: notification,
                      inactiveThumbColor: Colors.blueGrey,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        appCubit.changeNotificationState();
                      }),
                  const Spacer(),
                  Text(
                    "الأشعارات",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ]),
              ),
              const SizedBox(height: 30.0),
              //mode setting
              Container(
                height: 65.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                  border: Border.all(
                      color: Theme.of(context).iconTheme.color!, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Row(children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    onPressed: () {
                      appCubit.changeAppMode();
                    },
                    icon: mode
                        ? const Icon(Icons.light_mode)
                        : const Icon(Icons.dark_mode),
                    iconSize: 30.0,
                    color: mode ? Colors.yellow : Colors.grey,
                  ),
                  const Spacer(),
                  Text(
                    "مظهر التطبيق",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ]),
              ),
              const SizedBox(height: 30.0,),
              TextButton(
                onPressed: () {
                  CacheHelper.removeData(key: 'jwt');
                  CacheHelper.removeData(key: 'role');
                  jwt = '';
                  role = '';
                  navigateAndFinish(context, const LoginScreen());
                },
                child: const Text('تسجيل الخروج'))
            ]),
          ),
        );
      },
    );
  }
}
