import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/audio_player_widget.dart';
import 'package:quick_medcare/widgets/video_player_widget.dart';

class FilePreview extends StatefulWidget {
  final String message;
  final String? url;
  final String user;
  const FilePreview({
    super.key,
    required this.message,
    required this.url, required this.user,
  });

  @override
  State<FilePreview> createState() => _FilePreviewState();
}

class _FilePreviewState extends State<FilePreview> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text(widget.user, style: headLine3(black),),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.cancel))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
                height: size.height * 0.8,
                width: size.width,
                child: _buildMediaWidget(widget.url!, widget.message))
          ],
        ),
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
      return const Text('Unsupported media type');
    }
  }
}
