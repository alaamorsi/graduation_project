import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/student/my_courses/course_cubit/course_states.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:video_player/video_player.dart';

class CourseCubit extends Cubit<CourseStates> {
  CourseCubit() : super(CourseInitialStates());
  static CourseCubit get(context) => BlocProvider.of(context);

  late MyCourse openedCourse;
  void openCourse(MyCourse course) {
    openedCourse  = course;
    emit(OpenCourseState());
  }

  List<String> titles = [
    'Lessons',
    'Chats',
    'Assignments',
  ];
  // void changeBottomNav(int index) {
  //   currentIndex = index;
  //   emit(CourseChangeBottomNavState());
  // }


///////////////////////////////////////////////
  late FlickManager flickManager;
  int currentVideoIndex = 0;

  void initializeFlickManager(String lessonUrl) {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(lessonUrl),
      ),
      autoPlay: true,
      onVideoEnd: () {
        playNextVideo(currentVideoIndex);
      },
    );
    emit(InitializeFlickManagerState());
  }

  void playNextVideo(int currentVideo) {
    currentVideoIndex = ((currentVideo + 1) % openedCourse.lessons.length);
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(openedCourse.lessons[currentVideoIndex].videoUrl)),
    );
    emit(PlayNextVideoState());
  }

  void playWithName(int index,String lessonUrl) {
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(lessonUrl)),
    );
    currentVideoIndex = index;
    emit(InitVideoState());
  }

  void playPreviousVideo(int currentVideo) {
    currentVideoIndex = ((currentVideo - 1) % openedCourse.lessons.length);
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(openedCourse.lessons[currentVideoIndex].videoUrl)),
    );
    emit(PlayPreviousVideoState());
  }

  void disposeVideo() {
    flickManager.dispose();
    emit(DisposeVideoState());
  }
  void pauseVideo() {
    flickManager.flickControlManager?.pause();
    emit(DisposeVideoState());
  }

}