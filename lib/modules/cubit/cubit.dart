import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/cache_helper.dart';
import 'package:graduation_project/shared/dio_helper.dart';
import '../../shared/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  ThemeMode theme = ThemeMode.system;
  IconData modeIcon = mode ? Icons.light_mode : Icons.dark_mode;
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
        print(theme.name);
      }
    changeIcon();
    CacheHelper.saveData(key: 'appMode', value: mode);
    CacheHelper.saveData(key: 'tm', value: tm);
    emit(AppChangModeState());
  }
  void changeIcon()
  {
    ThemeMode M = ThemeMode.system;
    if(M == ThemeMode.light){
      modeIcon = Icons.light_mode;
    }
    else if(M == ThemeMode.dark)
    {
      modeIcon = Icons.dark_mode;
    }
    emit(AppChangModeIconState());
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

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(searchloading());
    search = [];

    Diohelper.getData(Url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '2871845932ca4f2c8e8a8594dada13d4',
    }).then((value) {
      // print(value.data['articles'][0]['title'].toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(searchDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(getdataerrorsearch(error.toString()));
    });
  }
}