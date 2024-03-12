import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/instructor/instructor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/opening/opening.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'modules/registeration/login/cubit/cubit.dart';
import 'modules/registeration/register/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  mode = CacheHelper.getData(key: 'appMode')??mode;
  langTitle = CacheHelper.getData(key: 'ln')??langTitle;
  notification = CacheHelper.getData(key: 'notification')??notification;
  jwt = CacheHelper.getData(key: 'jwt')??"";
  role = CacheHelper.getData(key: 'role')??"";
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
        BlocProvider(create: (context)=>StudentCubit()..getUser()..getImage()),
        BlocProvider(create: (context)=>InstructorCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).theme,
            darkTheme: AppCubit.get(context).darkTheme,
            themeMode: AppCubit.get(context).appMode,
            home:const OpeningScreen(),
          );
        },
      ),
    );
  }
}