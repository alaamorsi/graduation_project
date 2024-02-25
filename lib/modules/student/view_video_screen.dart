import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

enum Source { Asset, Network }

class ViewVideoScreen extends StatefulWidget {
  const ViewVideoScreen({super.key});

  @override
  State<ViewVideoScreen> createState() => _ViewVideoScreenState();
}

class _ViewVideoScreenState extends State<ViewVideoScreen> {
  late CustomVideoPlayerController customVideoPlayerController;
  Source currentSource = Source.Asset;
  String videoAsset = "Assets/menshawy.mp4";
  Uri videoLink = Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer(currentSource);
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
          CustomVideoPlayer(
            customVideoPlayerController: customVideoPlayerController,
          ),
          sourceButtons(),
        ],
      ),
    );
  }

  Widget sourceButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            setState(() {
              currentSource = Source.Network;
              initializeVideoPlayer(currentSource);
            });
          },
          color: Colors.red,
          child: const Text(
            'Network',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        MaterialButton(
          onPressed: () {
            currentSource = Source.Asset;
            initializeVideoPlayer(currentSource);
          },
          color: Colors.red,
          child: const Text(
            'Asset',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void initializeVideoPlayer(Source source) {
    VideoPlayerController videoPlayerController;
    if (source == Source.Network)
      {
        videoPlayerController = VideoPlayerController.networkUrl(videoLink)
          ..initialize().then((value) => () {
            setState(() {});
          });
      }
    else if (source == Source.Asset)
      {
        videoPlayerController = VideoPlayerController.asset(videoAsset)
          ..initialize().then((value) => () {
            setState(() {});
          });

      } else
        {
          return;
        }

    customVideoPlayerController = CustomVideoPlayerController(
        context: context, videoPlayerController: videoPlayerController);
  }
}
