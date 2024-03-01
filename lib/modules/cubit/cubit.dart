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

  // Change language by default arabic
  void changeAppLanguage(context,String ln) {
    langTitle=(ln=="ar")?'Arabic':'English';
    CacheHelper.saveData(key: 'ln', value: ln);
    emit(AppChangModeState());
  }

  // Change application mode state
  void changeAppMode() {
    mode=!mode;
    theme = mode?ThemeMode.light:ThemeMode.dark;
    CacheHelper.putBoolean(key: 'appMode', value: mode);
    emit(AppChangModeState());
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
