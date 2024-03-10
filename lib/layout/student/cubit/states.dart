abstract class StudentStates {}

class StudentInitialStates extends StudentStates {}

class StudentChangeBottomNavState extends StudentStates {}

class CheckViewDemoListState extends StudentStates {}

class CheckPaymentState extends StudentStates {}

class CheckFavoriteState extends StudentStates {}

class StartSearchState extends StudentStates {}

class PaymentManagerLoadingState extends StudentStates {}

class PaymentManagerSuccessState extends StudentStates {}

class PaymentManagerErrorState extends StudentStates {
  final String error;

  PaymentManagerErrorState(this.error);
}



class StudentHasImageState extends StudentStates {}
// pick image
class ProfileImagePickedSuccessState extends StudentStates {}

class ProfileImagePickedErrorState extends StudentStates {}

// Get user states
class UpdateUserDataLoadingState extends StudentStates {}

class UpdateFirstNameSuccessState extends StudentStates {}
class UpdateLastNameSuccessState extends StudentStates {}
class UpdateBioSuccessState extends StudentStates {}
class UpdateProfileImageSuccessState extends StudentStates {}

class UpdateUserDataErrorState extends StudentStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}

class GetUserDataSuccessState extends StudentStates {}
