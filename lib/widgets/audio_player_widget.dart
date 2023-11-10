import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class AudioPlayerWidgets extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidgets(this.audioUrl, {super.key});
  @override
  State<AudioPlayerWidgets> createState() => _AudioPlayerWidgetsState();
}

class _AudioPlayerWidgetsState extends State<AudioPlayerWidgets> {
 // final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool _isDisposed = false; // Add this flag

  @override
  void initState() {
    super.initState();
    // _audioPlayer.onPlayerStateChanged.listen((event) {
    //   if (!_isDisposed) { // Check if the widget is disposed
    //     if (event == PlayerState.playing) {
    //       setState(() {
    //         isPlaying = true;
    //       });
    //     } else if (event == PlayerState.stopped || event == PlayerState.completed) {
    //       setState(() {
    //         isPlaying = false;
    //       });
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    _isDisposed = true; // Set the flag to true when the widget is disposed
  //  _audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isPlaying
            ? IconButton(
                icon: Icon(Icons.pause, color: black),
                onPressed: () => _pauseAudio(),
              )
            : IconButton(
                icon: Icon(Icons.play_circle_filled, color: black, size: 40),
                onPressed: () => _playAudio(),
              ),
        Text('Audio Playback', style: bodyText4(black)),
      ],
    );
  }

  void _playAudio() async {
    try {
// AssetsAudioPlayer.newPlayer().open(
//     Audio("icons/song.mp3"),
//     autoStart: true,
//     showNotification: true,
// );
      // await _audioPlayer.setSource(UrlSource('https://firebasestorage.googleapis.com/v0/b/quick-med-ef517.appspot.com/o/uploads%2FHalleluyah.mp3?alt=media&token=d3be7e8c-8e25-4ca5-b869-cfdaf19860c2'));
      // await _audioPlayer.play(UrlSource('https://firebasestorage.googleapis.com/v0/b/quick-med-ef517.appspot.com/o/uploads%2FHalleluyah.mp3'));
   
     // print(widget.audioUrl);
    } catch (e) {
      // print(widget.audioUrl);
      // print("Error playing audio: $e");
    }
  }

  void _pauseAudio() async {
    try {
     // await _audioPlayer.pause();
    } catch (e) {
      print("Error pausing audio: $e");
    }
  }

  
}
