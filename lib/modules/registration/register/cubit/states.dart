abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}

class RegErrorRepeatedUserNameState extends RegisterStates {}

class RegErrorRepeatedEmailState extends RegisterStates {}

class RegErrorServerErrorState extends RegisterStates {}

class ChangePasswordVisibilityState extends RegisterStates {}

class GetUserLoadingState extends RegisterStates {}

class ChangeAcceptOfConditions extends RegisterStates {}

// send Confirmation
class SendConfirmSuccessState extends RegisterStates {}

class SendConfirmErrorState extends RegisterStates {}

class SendConfirmFailedState extends RegisterStates {}

class CheckCodeConfirmLoadingState extends RegisterStates {}

class CheckCodeConfirmSuccessState extends RegisterStates {}

class CheckCodeConfirmErrorState extends RegisterStates {}
