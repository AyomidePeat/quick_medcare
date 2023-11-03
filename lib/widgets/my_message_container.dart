import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/audio_player_widget.dart';
import 'package:quick_medcare/widgets/video_player_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  final String? url;
  
  const MyMessageContainer(
      {super.key, required this.message, required this.date, this.url,});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          url != null
              ? Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: grey,
                  ),
                  child: _buildMediaWidget(url!, message),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Text(
                    message,
                    style: bodyText3(white),
                  ),
                ),
          Text(
            date,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins-Regular',
                fontSize: 9,
                color: black),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaWidget(String url, String message) {
    final uri = Uri.parse(url);
    if (message.endsWith('.jpg') ||
        message.endsWith('.png') ||
        message.endsWith('.jpeg')) {
      return Image.network(url, fit: BoxFit.cover);
    } else if (message.endsWith('.mp4')) {
      return VideoPlayerWidget(uri);
    } else if (message.endsWith('.mp3')) {
      return AudioPlayerWidgets(url);
    } else {
      return Text('Unsupported media type');
    }
  }
}
