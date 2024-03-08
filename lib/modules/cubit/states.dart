abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangModeState extends AppStates {}

class AppChangThemeState extends AppStates {}

class AppChangLanguageState extends AppStates {}

class AppChangeNotificationState extends AppStates {}

class AppGetSettingsState extends AppStates {}

class GetSearchDataLoading extends AppStates {}

class GetSearchDataSuccess extends AppStates {}

class GetSearchDataError extends AppStates {
  final String error;

  GetSearchDataError(this.error);
}

class SearchFilterOpenState extends AppStates {}

class SearchFilterCloseState extends AppStates {}

class MakeSearchFilter extends AppStates {}


