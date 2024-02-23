abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class ChangePasswordVisibilityState extends RegisterStates {}

class GetUserLoadingState extends RegisterStates {}

class ChangeAcceptOfConditions extends RegisterStates {}

// send Confirmation
class SendConfirmSuccessState extends RegisterStates {}

class SendConfirmErrorState extends RegisterStates {
  final String error;

  SendConfirmErrorState(this.error);
}
class CheckCodeConfirmLoadingState extends RegisterStates {}
class CheckCodeConfirmSuccessState extends RegisterStates {}

class CheckCodeConfirmErrorState extends RegisterStates {
  final String error;

  CheckCodeConfirmErrorState(this.error);
}
