import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/cache_helper.dart';
import '../../shared/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  IconData appMode = Icons.light_mode;
  ThemeMode theme = ThemeMode.system;


  void changeAppMode(String tm) {
    if (tm=="فاتح")
      {
        theme = ThemeMode.light;
        mode = true;
        logoImage = "Assets/logo1.png";
      }
    else if(tm=="غامق")
      {
        theme = ThemeMode.dark;
        logoImage = "Assets/logo2.png";
        mode = false;
      }
    else
      {
        theme = ThemeMode.system;
        if(theme == ThemeMode.light){
          theme = ThemeMode.light;
          logoImage = "Assets/logo1.png";
          mode = true;
        }
        else
        {
          theme = ThemeMode.dark;
          logoImage = "Assets/logo2.png";
          mode = false;
        }
      }
    CacheHelper.saveData(key: 'appMode', value: mode);
    appMode = mode ? Icons.light_mode : Icons.dark_mode;
    emit(AppChangModeState());
  }

  // Change accept conditions
  String appLang = 'Arabic';
  bool lang = true;
  void changeAppLanguage() {
    lang = !lang;
    CacheHelper.saveData(key: 'appLang', value: lang);
    appLang = lang ? 'Arabic' : 'English';
    emit(AppChangModeState());
  }
}