abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginNotConfirmedState extends LoginStates {}

class LoginNotFoundState extends LoginStates {}

class FormatErrorState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}

// Reset password states
class ResetPasswordLoadingState extends LoginStates {}

class ResetPasswordSuccessState extends LoginStates {}

class ResetPasswordErrorState extends LoginStates {
  final String error;

  ResetPasswordErrorState(this.error);
}

// Validate reset password code
class ValidateResetPasswordLoadingState extends LoginStates {}

class ValidateResetPasswordSuccessState extends LoginStates {}

class ValidateResetPasswordErrorState extends LoginStates {
  final String error;

  ValidateResetPasswordErrorState(this.error);
}

// Send reset code
class SendResetCodeLoadingState extends LoginStates {}

class SendResetCodeSuccessState extends LoginStates {}

class SendResetCodeErrorState extends LoginStates {
  final String error;

  SendResetCodeErrorState(this.error);
}

class SendResetCodeFailedState extends LoginStates {}

class SendConfirmSuccessState extends LoginStates {}

class SendConfirmErrorState extends LoginStates {
  final String error;

  SendConfirmErrorState(this.error);
}

class SendConfirmFailedState extends LoginStates {}
