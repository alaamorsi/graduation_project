import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/splash.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  mode = CacheHelper.getData(key: 'appMode')??mode;
  uId = CacheHelper.getData(key: 'id')??uId;
  role = CacheHelper.getData(key: 'role')??role;
  runApp(MyApp(appMode: mode));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor:Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool appMode;
  const MyApp({super.key,
    required this.appMode,
  });

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            locale: AppCubit.get(context).language,
            themeMode: AppCubit.get(context).theme,
            home:const SplashScreen(),
          );
        },
      ),
    );
  }
}