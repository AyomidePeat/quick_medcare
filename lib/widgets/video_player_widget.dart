import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Uri videoUrl;

  const VideoPlayerWidget(this.videoUrl);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void _togglePlayPause() {
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _videoController.value.isInitialized?
    InkWell(
            onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
         isPlaying &&_videoController.value.isPlaying? const Positioned.fill(
                  child: Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 48.0,
                  ),
                )
              : const Positioned.fill(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 48.0,
                  ),
                ),
        ],
      ),
    ):const Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }
}
