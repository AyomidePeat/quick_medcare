import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class AudioPlayerWidgets extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidgets(this.audioUrl);
  @override
  State<AudioPlayerWidgets> createState() => _AudioPlayerWidgetsState();
}

class _AudioPlayerWidgetsState extends State<AudioPlayerWidgets> {
 

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
      } else if (event == PlayerState.stopped || event == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isPlaying
            ? IconButton(
                icon: Icon(Icons.pause),
                onPressed: () => _audioPlayer.pause(),
              )
            : IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () => _audioPlayer.play(UrlSource(widget.audioUrl)),
              ),
        Text('Audio Playback'),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
  }
}





