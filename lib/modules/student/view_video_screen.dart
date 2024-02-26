import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({Key? key}) : super(key: key);

  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  late FlickManager flickManager;
  List<String> videoUrls = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    // Add more video URLs here if needed
  ];
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(videoUrls[currentVideoIndex]),
      ),
    );
  }

  void playNextVideo() {
    // Increment the index to switch to the next video
    currentVideoIndex = (currentVideoIndex + 1) % videoUrls.length;
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(
        Uri.parse(videoUrls[currentVideoIndex]),
      ),
    );
  }
  void playPreviousVideo() {
    // Increment the index to switch to the next video
    currentVideoIndex = (currentVideoIndex - 1) % videoUrls.length;
    flickManager.handleChangeVideo(
      VideoPlayerController.networkUrl(
        Uri.parse(videoUrls[currentVideoIndex]),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          FlickVideoPlayer(flickManager: flickManager),
          Visibility(
            visible: !flickManager.flickControlManager!.isFullscreen,
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: playNextVideo,
                      child: const Text('Play Next Video'),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: playNextVideo,
                      child: const Text('Play Next Video'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
