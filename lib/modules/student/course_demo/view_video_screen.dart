import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:video_player/video_player.dart';
import '../../../shared/component/components.dart';

class ViewVideoScreen extends StatefulWidget {
  final String introUrl;
  const ViewVideoScreen({super.key, required this.introUrl});

  @override
  ViewVideoScreenState createState() =>ViewVideoScreenState();
}

class ViewVideoScreenState extends State<ViewVideoScreen> {
  late FlickManager flickManager;
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeFlickManager();
  }

  void initializeFlickManager() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.introUrl),
      ),
      autoPlay: true, // Automatically start playing the video
      onVideoEnd: () {
      },
    );
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
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlickVideoPlayer(flickManager: flickManager),
            ],
          ),
        );
      }
    );
  }
}

