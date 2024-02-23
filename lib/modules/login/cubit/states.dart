abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}
class LoginNotConfirmedState extends LoginStates {}
class LoginNotFoundState extends LoginStates {}
class LoginFormatErrorState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}

class GetUserLoadingState extends LoginStates {}

class ChangeAcceptOfConditions extends LoginStates {}
