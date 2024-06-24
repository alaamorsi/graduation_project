abstract class InstructorStates {}

class InstructorInitialStates extends InstructorStates {}

///implemented when app initialize and when data updated
class GetUserDataSuccessState extends InstructorStates {}

class HasImageState extends InstructorStates {}

// pick image
class ProfileImagePickedSuccessState extends InstructorStates {}

class ProfileImagePickedErrorState extends InstructorStates {}

// pick video
class VideoPickedSuccessState extends InstructorStates {}

class VideoPickedErrorState extends InstructorStates {}

// Get user states
class UpdateUserDataLoadingState extends InstructorStates {}

class UpdateFirstNameSuccessState extends InstructorStates {}

class UpdateLastNameSuccessState extends InstructorStates {}

class UpdateBioSuccessState extends InstructorStates {}

class UpdateProfileImageLoadingState extends InstructorStates {}

class UpdateProfileImageSuccessState extends InstructorStates {}

class UpdateProfileImageErrorState extends InstructorStates {}

class UpdateUserDataErrorState extends InstructorStates {}

class InstructorChangeBottomNavState extends InstructorStates {}

class SelectionState extends InstructorStates {}

// button back
class EnableButtonBackState extends InstructorStates {}

// payMob states
class PaymentManagerLoadingState extends InstructorStates {}

class PaymentManagerSuccessState extends InstructorStates {}

class PaymentManagerErrorState extends InstructorStates {}

// log out tutor
class LogOutLoadingInsState extends InstructorStates {}

class LogOutSuccessState extends InstructorStates {}

class LogOutErrorState extends InstructorStates {}

// Session Ended
class SessionEndedState extends InstructorStates {}

// Publish course states
class PublishCourseLoadingState extends InstructorStates {}

class PublishCourseSuccessState extends InstructorStates {}

class PublishCourseErrorState extends InstructorStates {}

// Instructor Courses
class GetInstCoursesLoadingState extends InstructorStates {}

class GetInstCoursesSuccessState extends InstructorStates {}

class GetInstCoursesErrorState extends InstructorStates {}

// for publish course
class ShowPopMassageState extends InstructorStates {}

// course lessons
class GetInstCourseLessonsLoadingState extends InstructorStates {}

class GetInstCourseLessonsSuccessState extends InstructorStates {}

class GetInstCourseLessonsErrorState extends InstructorStates {}

// add lesson
class AddLessonLoadingState extends InstructorStates {}

class AddLessonSuccessState extends InstructorStates {}

class AddLessonErrorState extends InstructorStates {}

// course students
class InstGetStudentsLoadingState extends InstructorStates {}

class InstGetStudentsSuccessState extends InstructorStates {}

class InstGetStudentsErrorState extends InstructorStates {}

// attachments
class InstGetAttachmentsLoadingState extends InstructorStates {}

class InstGetAttachmentsSuccessState extends InstructorStates {}

class InstGetAttachmentsErrorState extends InstructorStates {}

class AddAttachmentLoadingState extends InstructorStates {}

class AddAttachmentSuccessState extends InstructorStates {}

class AddAttachmentErrorState extends InstructorStates {}

// assignments
class InstGetAssignmentsLoadingState extends InstructorStates {}
class InstGetAssignmentsSuccessState extends InstructorStates {}
class InstGetAssignmentsErrorState extends InstructorStates {}
class AddAssignmentLoadingState extends InstructorStates {}
class AddAssignmentSuccessState extends InstructorStates {}
class AddAssignmentErrorState extends InstructorStates {}
class AddGradeForSolutionLoadingState extends InstructorStates {}
class AddGradeForSolutionSuccessState extends InstructorStates {}
class AddGradeForSolutionErrorState extends InstructorStates {}
class ShowAddGradeDialogState extends InstructorStates {}

//add description
class AddDescriptionLoadingState extends InstructorStates {}

class AddDescriptionSuccessState extends InstructorStates {}

class AddDescriptionErrorState extends InstructorStates {}

// file
class FilePickedSuccessState extends InstructorStates {}

class FilePickedErrorState extends InstructorStates {}

class FileClearState extends InstructorStates {}

class FileOpenedSuccessState extends InstructorStates {}

class FileOpenedErrorState extends InstructorStates {}

class TimePickedSuccessState extends InstructorStates {}

//chat
class GetChatLoadingState extends InstructorStates {}
class GetChatSuccessState extends InstructorStates {}
class GetChatErrorState extends InstructorStates {}
class MessageAddToChatState extends InstructorStates {}
