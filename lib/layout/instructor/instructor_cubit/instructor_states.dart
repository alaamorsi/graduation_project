abstract class InstructorStates {}

class InstructorInitialStates extends InstructorStates {}

///implemented when app initialize and when data updated
class GetUserDataSuccessState extends InstructorStates {}

class HasImageState extends InstructorStates {}

// pick image
class ProfileImagePickedSuccessState extends InstructorStates {}

class ProfileImagePickedErrorState extends InstructorStates {}
// Get user states
class UpdateUserDataLoadingState extends InstructorStates {}
class UpdateFirstNameSuccessState extends InstructorStates {}
class UpdateLastNameSuccessState extends InstructorStates {}
class UpdateBioSuccessState extends InstructorStates {}
class UpdateProfileImageLoadingState extends InstructorStates {}
class UpdateProfileImageSuccessState extends InstructorStates {}
class UpdateProfileImageErrorState extends InstructorStates {}
class UpdateUserDataErrorState extends InstructorStates {
  final String error;
  UpdateUserDataErrorState(this.error);
}
class InstructorChangeBottomNavState extends InstructorStates {}

class ChangeCourseTypeSelectionState extends InstructorStates {}

class AddNewCourseSelectionState extends InstructorStates {}