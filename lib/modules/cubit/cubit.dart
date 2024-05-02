import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/themes.dart';
import '../../shared/component/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  ThemeMode appMode = mode?ThemeMode.light:ThemeMode.dark;
  ThemeData theme = blueTheme;
  ThemeData darkTheme = blueDarkTheme;
  String language = langTitle;

  // Change language by default arabic
  void changeAppLanguage(String lang) {
    language = lang;
    isArabic = lang=='ar'?true:false;
    Get.updateLocale(Locale(lang));
    CacheHelper.saveData(key: 'language', value: lang);
  }

  // Change application mode state
  void changeAppMode() {
    mode=!mode;
    appMode = mode?ThemeMode.light:ThemeMode.dark;
    CacheHelper.putBoolean(key: 'appMode', value: mode);
    emit(AppChangModeState());
  }

  void changeTheme(int themeId) {
    if(themeId==1){
      theme = orangeTheme;
      darkTheme = orangeDarkTheme;
    }
    else if(themeId==2){
      theme = greenTheme;
      darkTheme =greenDarkTheme;
    }
    else if(themeId==3){
      theme = blueTheme;
      darkTheme =blueDarkTheme;
    }
    else if(themeId==4){
      theme = purpleTheme;
      darkTheme = purpleDarkTheme;
    }
    CacheHelper.saveData(key: 'themeId', value: themeId);
    emit(AppChangThemeState());
  }

  // Change notification state
  void changeNotificationState() {
    notification = !notification;
    CacheHelper.putBoolean(key: 'notification', value: notification);
    emit(AppChangeNotificationState());
  }
}

