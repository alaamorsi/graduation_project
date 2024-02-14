abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangModeState extends AppStates {}

class AppChangLanguageState extends AppStates {}

class  getdataerrorsearch extends AppStates{
  final String error;

  getdataerrorsearch(this.error);
}

class searchDataSuccess extends AppStates{}

class searchloading extends AppStates{}
