import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import 'package:graduation_project/shared/themes.dart';
import '../../shared/component/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  ThemeMode appMode = mode?ThemeMode.light:ThemeMode.dark;
  ThemeData theme = blueTheme;
  ThemeData darkTheme = blueDarkTheme;

  // Change language by default arabic
  void changeAppLanguage(context,String ln) {
    langTitle=(ln=="ar")?'Arabic':'English';
    CacheHelper.saveData(key: 'ln', value: ln);
    emit(AppChangModeState());
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

  List<String> selectedItems = [];
  List<dynamic> search = [];

  String startValue ='Arabic';

  void getSearch(String value) {
    emit(GetSearchDataLoading());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': '2871845932ca4f2c8e8a8594dada13d4',
    }).then((value) {
      search = value.data['articles'];
      emit(GetSearchDataSuccess());
    }).catchError((error) {
      emit(GetSearchDataError(error.toString()));
    });
  }
  void searchBy(String value) {
    emit(MakeSearchFilter());
  }
}

