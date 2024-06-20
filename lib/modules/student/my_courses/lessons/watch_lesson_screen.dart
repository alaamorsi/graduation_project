import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/lesson_model.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:video_player/video_player.dart';

class WatchLessonScreen extends StatefulWidget {
  final LessonModel lesson;
  final int index;
  const WatchLessonScreen({super.key, required this.lesson, required this.index});

  @override
  WatchLessonScreenState createState() =>WatchLessonScreenState();
}

class WatchLessonScreenState extends State<WatchLessonScreen> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    initializeFlickManager();
  }

  String newUrl(String url){
  String newUrl = url.substring(8);
  newUrl = 'https://digitutors.runasp.net/$newUrl';
  print(newUrl);
  return newUrl;
  }
  void initializeFlickManager() {

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(newUrl(widget.lesson.videoUrl)),
      ),
      autoPlay: true, // Automatically start playing the video
      onVideoEnd: () {
        if(widget.index+2>lessons.length){
          playNextVideo(StudentCubit.get(context).lessons[0]);
        }
        else{
          playNextVideo(StudentCubit.get(context).lessons[widget.index+1]);
        }
      },
    );
  }

  void playNextVideo(LessonModel lesson) {
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(newUrl(lesson.videoUrl))),
    );
  }


  void playPreviousVideo(LessonModel lesson) {
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(Uri.parse(newUrl(lesson.videoUrl))),
    );
  }

  void pauseVideo() {
    flickManager.flickControlManager?.pause();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context , state ){},
        builder: (context , state ){
          return Scaffold(
            appBar:secondAppbar(
              context: context,
              title: 'Introduction'.tr,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlickVideoPlayer(flickManager: flickManager),
                if(flickManager.flickVideoManager!.isVideoEnded)
                  BlocConsumer<StudentCubit,StudentStates>(
                    listener: (context,state){},
                    builder: (context,state){
                      var cubit = StudentCubit.get(context);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: (){
                            if(widget.index+2>lessons.length){
                              playNextVideo(cubit.lessons[0]);
                            } else{
                              playNextVideo(cubit.lessons[widget.index+1]);
                            }
                          }, icon: const Icon(Icons.skip_next)),
                          const Spacer(),
                          IconButton(onPressed: (){
                            if(widget.index-1<0){
                              playPreviousVideo(cubit.lessons[lessons.length-1]);
                            } else{
                              playPreviousVideo(cubit.lessons[widget.index-1]);
                            }
                          }, icon: const Icon(Icons.skip_previous)),
                        ],
                      );
                    },
                  )
              ],
            ),
          );
        }
    );
  }
}