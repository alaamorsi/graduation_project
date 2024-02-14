import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/splash.dart';
import 'package:graduation_project/shared/cache_helper.dart';
import 'package:graduation_project/shared/constant.dart';
import 'package:graduation_project/shared/dio_helper.dart';
import 'package:graduation_project/shared/themes.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Diohelper.init();
  await CacheHelper.init();
  mode = CacheHelper.getData(key: 'appMode')??mode;
  runApp(MyApp(appMode: mode));
}
class MyApp extends StatelessWidget {
  bool appMode;
  MyApp({
    required this.appMode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).theme,
            home:splash(),
          );
        },
      ),
    );
  }
}
