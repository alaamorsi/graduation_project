import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:graduation_project/shared/network/dio_helper.dart';
import '../../shared/component/constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

 // Control to visible or invisible password
  ThemeMode theme = ThemeMode.light;
  void changeAppMode() {
    mode=!mode;
    if(mode){
      theme = ThemeMode.light;
    }
    else{
      theme =ThemeMode.dark;
    }
    CacheHelper.putBoolean(key: 'appMode', value: mode);
    emit(AppChangModeState());
  }

  // Change notification state
  bool notification = true;
  void changeNotificationState() {
    notification = !notification;
    CacheHelper.putBoolean(key: 'notification', value: notification);
    emit(AppChangeNotificationState());
  }

  // Change language by default arabic
  Locale language = const Locale('ar',);
  void changeAppLanguage(String ln) {
    if (ln=="en")
    {
      language = const Locale('en',);
    }
    else if(ln=="ar")
    {
      language = const Locale('ar',);
    }
    CacheHelper.saveData(key: 'ln', value: ln);
    emit(AppChangModeState());
  }

  bool isFilterOpen = false ;
  List<String> selectedItems = [];
  List<dynamic> search = [];

  late OverlayEntry entry;
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
