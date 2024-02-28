import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAndChatScreen extends StatefulWidget {
  const VideoAndChatScreen({super.key});

  @override
  VideoAndChatScreenState createState() =>VideoAndChatScreenState();
}

class VideoAndChatScreenState extends State<VideoAndChatScreen> {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        bottomOpacity: 0.7,
        elevation: 2.0,
        shadowColor: Colors.grey,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70.0),
            bottomRight: Radius.circular(70.0),
          ),
        ),
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back_ios_rounded)
        ),
        title: const Text('ابو عمر السوري'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              FlickVideoPlayer(flickManager: flickManager),
              Visibility(
                visible: !flickManager.flickControlManager!.isFullscreen,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: playPreviousVideo,
                            icon: const Icon(Icons.skip_previous_rounded),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: playNextVideo,
                            icon: const Icon(Icons.skip_next_rounded),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: !flickManager.flickControlManager!.isFullscreen,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: playPreviousVideo,
                        child: const Row(
                          children: [
                            Icon(Icons.navigate_before),
                            Text('الدرس السابق'),
                          ],
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: playNextVideo,
                        child: const Row(
                          children: [
                            Text('الدرس التالي'),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
