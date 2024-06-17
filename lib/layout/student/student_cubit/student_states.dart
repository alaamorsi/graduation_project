abstract class StudentStates {}

class StudentInitialStates extends StudentStates {}

///implemented when app initialize and when data updated
class GetUserDataSuccessState extends StudentStates {}

class StudentHasImageState extends StudentStates {}

class StudentChangeBottomNavState extends StudentStates {}

class CheckFavoriteState extends StudentStates {}

// all Courses
class GetCoursesLoadingState extends StudentStates {}

class GetCoursesSuccessState extends StudentStates {}

class GetCoursesErrorState extends StudentStates {}

//top rated Courses
class GetTopRatedCoursesLoadingState extends StudentStates {}

class GetTopRatedCoursesSuccessState extends StudentStates {}

class GetTopRatedCoursesErrorState extends StudentStates {}

//top rated Courses
class GetTopSalesCoursesLoadingState extends StudentStates {}

class GetTopSalesCoursesSuccessState extends StudentStates {}

class GetTopSalesCoursesErrorState extends StudentStates {}

//enrolled Courses
class GetCoursesEnrolledLoadingState extends StudentStates {}

class GetCoursesEnrolledSuccessState extends StudentStates {}

class GetCoursesEnrolledErrorState extends StudentStates {}

// search
class StartSearchState extends StudentStates {}
class ChangeTheSearchCategoryState extends StudentStates {}
class ShowSearchFilterState extends StudentStates {}

class SearchLoadingState extends StudentStates {}

class SearchSuccessState extends StudentStates {}

class SearchErrorState extends StudentStates {}

//
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
