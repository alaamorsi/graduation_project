import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:video_player/video_player.dart';

import '../../../shared/component/components.dart';

class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({super.key});

  @override
  ViewVideoScreenState createState() =>ViewVideoScreenState();
}

class ViewVideoScreenState extends State<ViewVideoScreen> {
  late FlickManager flickManager;
  List<String> videoUrls = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    // Add more video URLs here if needed
  ];
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeFlickManager();
  }

  void initializeFlickManager() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(videoUrls[currentVideoIndex]),
      ),
      autoPlay: true, // Automatically start playing the video
      onVideoEnd: () {
        // When the video ends, play the next video
        playNextVideo();
      },
    );
  }

  void playNextVideo() {
    setState(() {
      currentVideoIndex = (currentVideoIndex + 1) % videoUrls.length;
      flickManager.handleChangeVideo(
        VideoPlayerController.networkUrl(Uri.parse(videoUrls[currentVideoIndex])),
      );
    });
  }

  void playPreviousVideo() {
    setState(() {
      currentVideoIndex = (currentVideoIndex - 1) % videoUrls.length;
      flickManager.handleChangeVideo(
        VideoPlayerController.networkUrl(Uri.parse(videoUrls[currentVideoIndex])),
      );
    });
  }

  @override
  void dispose() {
    flickManager.dispose(); // Dispose of the flick manager when the screen is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    return BlocConsumer<StudentCubit,StudentStates>(
        listener: (context , state ){},
        builder: (context , state ){
          return Scaffold(
            appBar:secondAppbar(
            context: context,
            title: 'Course title',
            hasAction: true,
            actionIcon: IconButton(
                onPressed: (){
                  cubit.checkFavorite();
                },
                icon: cubit.isFavorite? const Icon( Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_border)),),
            body: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  FlickVideoPlayer(flickManager: flickManager),
                  nextAndPrevious(),
                ],
              ),
            ],
          ),
      );
        }
    );
  }
  Widget nextAndPrevious(){
    if(!flickManager.flickControlManager!.isFullscreen )
      {
       return  Padding(
         padding: const EdgeInsets.all(30.0),
         child: Column(
           children: [
             Row(
               children: [
                 PhysicalModel(
                   color: Colors.grey,
                   shape: BoxShape.circle,
                   child: IconButton(
                     onPressed: playPreviousVideo,
                     icon: const Icon(Icons.skip_previous_rounded),
                   ),
                 ),
                 const Spacer(),
                 PhysicalModel(
                   color: Colors.grey,
                   shape: BoxShape.circle,
                   child: IconButton(
                     onPressed: playNextVideo,
                     icon: const Icon(Icons.skip_next_rounded),
                   ),
                 ),
               ],
             ),
           ],
         ),
       );
      }
    else
      {
        return const SizedBox();
      }
  }
}

