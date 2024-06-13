abstract class StudentStates {}

class StudentInitialStates extends StudentStates {}

///implemented when app initialize and when data updated
class GetUserDataSuccessState extends StudentStates {}

class StudentHasImageState extends StudentStates {}

class StudentChangeBottomNavState extends StudentStates {}

class CheckFavoriteState extends StudentStates {}

class StudentGetCoursesLoadingState extends StudentStates {}

class StudentGetCoursesSuccessState extends StudentStates {}

class StudentGetCoursesErrorState extends StudentStates {}

class StartSearchState extends StudentStates {}

class PaymentManagerLoadingState extends StudentStates {}

class PaymentManagerSuccessState extends StudentStates {}

class PaymentManagerErrorState extends StudentStates {}

// pick image
class ProfileImagePickedSuccessState extends StudentStates {}

class ProfileImagePickedErrorState extends StudentStates {}

//logout
class LogOutLoadingState extends StudentStates {}

class LogOutSuccessState extends StudentStates {}

class LogOutErrorState extends StudentStates {}

// Session Ended
class SessionEndedState extends StudentStates {}

// Get user states
class UpdateUserDataLoadingState extends StudentStates {}

class UpdateFirstNameSuccessState extends StudentStates {}

class UpdateLastNameSuccessState extends StudentStates {}

class UpdateBioSuccessState extends StudentStates {}

class UpdateProfileImageLoadingState extends StudentStates {}

class UpdateProfileImageSuccessState extends StudentStates {}

class UpdateProfileImageErrorState extends StudentStates {}

class UpdateUserDataErrorState extends StudentStates {}
