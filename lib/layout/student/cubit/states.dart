abstract class StudentStates {}

class StudentInitialStates extends StudentStates {}


///implemented when app initialize and when data updated
class GetUserDataSuccessState extends StudentStates {}

class StudentHasImageState extends StudentStates {}

class StudentChangeBottomNavState extends StudentStates {}

class CheckFavoriteState extends StudentStates {}

class StartSearchState extends StudentStates {}

class PaymentManagerLoadingState extends StudentStates {}

class PaymentManagerSuccessState extends StudentStates {}

class PaymentManagerErrorState extends StudentStates {
  final String error;

  PaymentManagerErrorState(this.error);
}


// pick image
class ProfileImagePickedSuccessState extends StudentStates {}

class ProfileImagePickedErrorState extends StudentStates {}

// Get user states
class UpdateUserDataLoadingState extends StudentStates {}
class UpdateFirstNameSuccessState extends StudentStates {}
class UpdateLastNameSuccessState extends StudentStates {}
class UpdateBioSuccessState extends StudentStates {}
class UpdateProfileImageLoadingState extends StudentStates {}
class UpdateProfileImageSuccessState extends StudentStates {}
class UpdateProfileImageErrorState extends StudentStates {}
class UpdateUserDataErrorState extends StudentStates {}
