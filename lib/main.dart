import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/modules/opening/opening.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'layout/student/student_cubit/student_cubit.dart';
import 'layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'modules/registration/login/cubit/cubit.dart';
import 'modules/registration/register/cubit/cubit.dart';
import 'package:get/get.dart';
import 'language/translation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  mode = CacheHelper.getData(key: 'appMode')??mode;
  notification = CacheHelper.getData(key: 'notification')??notification;
  firstInstall= CacheHelper.getData(key: 'firstInstall')??true;
  jwt = CacheHelper.getData(key: 'jwt')??jwt;
  role = CacheHelper.getData(key: 'role')??role;
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor:Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    int themeId = CacheHelper.getData(key: "themeId")??1;
    langTitle = CacheHelper.getData(key: 'language')??langTitle;
    isArabic = (langTitle =="ar")?true:false;
    return MultiBlocProvider (
      providers: [
        BlocProvider(create: (context)=>AppCubit()..changeTheme(themeId)),
        BlocProvider(create: (context)=>LoginCubit()),
        BlocProvider(create: (context)=>RegisterCubit()),
        BlocProvider(create: (context)=>StudentCubit()..getUser()..getImage()..getCourses(1)),
        BlocProvider(create: (context)=>InstructorCubit()..getData()..getImage()..getCourses()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppCubit.get(context).theme,
            darkTheme: AppCubit.get(context).darkTheme,
            themeMode: AppCubit.get(context).appMode,
            home:const OpeningScreen(),
            translations: Translation(),
            locale: Locale(langTitle),
            fallbackLocale: const Locale('ar'),
          );
        },
      ),
    );
  }
}