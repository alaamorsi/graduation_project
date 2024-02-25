import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({super.key});

  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  late FlickManager flickManager1;
  late FlickManager flickManager2;
  Uri videoLink = Uri.parse(
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
  // String videoAsset = "Assets/menshawy.mp4";
  @override
  void initState() {
    super.initState();
    flickManager1 = FlickManager(videoPlayerController: VideoPlayerController.networkUrl(videoLink));
    // flickManager2 = FlickManager(videoPlayerController: VideoPlayerController.asset(videoAsset));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FlickVideoPlayer(flickManager: flickManager1),
              ],
            ),
    );
  }
}
