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
  ThemeMode theme = ThemeMode.light;
  void changeAppMode(String tm) {
    if (tm=="Light")
      {
        theme = ThemeMode.light;
        mode = true;
      }
    else if(tm=="Dark")
      {
        theme = ThemeMode.dark;
        mode = false;
      }
    CacheHelper.putBoolean(key: 'appMode', value: mode);
    CacheHelper.saveData(key: 'tm', value: tm);
    emit(AppChangModeState());
  }

  // Change language by default arabic
  bool lang = true;
  void changeAppLanguage(String ln) {
    if (ln=="English")
    {
      lang = false;
    }
    else if(ln=="Arabic")
    {
      lang = true;
    }
    CacheHelper.putBoolean(key: 'appLang', value: lang);
    CacheHelper.saveData(key: 'ln', value: ln);
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