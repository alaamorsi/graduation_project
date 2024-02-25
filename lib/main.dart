import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/modules/student/view_video_screen.dart';
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
  jwt = CacheHelper.getData(key: 'jwt')??jwt;
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>StudentCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          AppCubit.get(context).getSettings();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            locale: AppCubit.get(context).language,
            themeMode: AppCubit.get(context).theme,
            home:const ViewVideoScreen(),
          );
        },
      ),
    );
  }
}