import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/audio_player_widget.dart';
import 'package:path/path.dart' as path;
import 'package:quick_medcare/widgets/video_player_widget.dart';

class FilePreview extends StatefulWidget {
  final String message;
  final String? url;
  final String user;
  const FilePreview({
    super.key,
    required this.message,
    required this.url,
    required this.user,
  });

  @override
  State<FilePreview> createState() => _FilePreviewState();
}

bool isDownloading = false;
void showLoading(context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                'Opening file...',
                style: bodyText4(Colors.grey),
              )
                  .animate(
                    onPlay: (controller) => controller.loop(),
                  )
                  .fadeIn(duration: 2000.ms)
                  .then(delay: 3000.ms)
                  .fadeOut(duration: 100.ms),
              const SizedBox(
                height: 15,
              ),
              const CircularProgressIndicator()
            ],
          ),
        );
      });
}

void exit(context) {
  Navigator.pop(context);
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
        title: Text(
          widget.user,
          style: headLine3(black),
        ),
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
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                FutureBuilder<void>(
                  future: downloadAndOpenFile(url),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Container(); // Return an empty container when not needed
                    }
                  },
                );
              },
              child: FadeInImage(
                  placeholder: AssetImage('images/userIcon.png'),
                  image: NetworkImage(
                    url,
                  )),
            ),
          ]);
    } else if (message.endsWith('.mp4')) {
    return FutureBuilder<void>(
                  future: downloadAndOpenFile(url),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Container(); // Return an empty container when not needed
                    }
                  },
                );
    } else if (message.endsWith('.mp3') ||
        message.endsWith('.wav') ||
        message.endsWith('.aac')) {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              final status = await Permission.manageExternalStorage.request();
              if (status.isGranted) {
                setState(() {
                  isDownloading = true;
                });
                if (isDownloading == true) {
                  showLoading(context);
                }
                await downloadAndOpenFile(url);
                setState(() {
                  isDownloading = false;
                  exit(context);
                });
              } else {
                // print('Permission denied');
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 300),
                const Icon(Icons.play_circle_fill),
                Text(
                  'Play file',
                  style: headLine2(black),
                ),
              ],
            ),
          ),
          if (isDownloading)
            FutureBuilder<void>(
              future: downloadAndOpenFile(url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(); // Return an empty container when not needed
                }
              },
            )
        ],
      );
    } else {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              final status = await Permission.manageExternalStorage.request();
              if (status.isGranted) {
                setState(() {
                  isDownloading = true;
                });
                showLoading(context);
                // Perform the file download and opening here
                await downloadAndOpenFile(url);
                setState(() {
                  isDownloading = false;
                  exit(context);
                });
              } else {
                print('Permission denied');
              }
            },
            child: Text(
              'Open file',
              style: headLine2(blue),
            ),
          ),
          if (isDownloading)
            FutureBuilder<void>(
              future: downloadAndOpenFile(url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(); // Return an empty container when not needed
                }
              },
            )
        ],
      );
    }
  }

  Future<void> downloadAndOpenFile(String fileUrl) async {
    try {
      final response = await http.get(Uri.parse(fileUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // Determine the file extension from the URL
        final uri = Uri.parse(fileUrl);
        final extension = path.extension(uri.path);

        // Check for "Content-Disposition" header to get the filename
        final contentDisposition = response.headers['content-disposition'];
        String fileName = '${widget.message}$extension';

        if (contentDisposition != null) {
          final match = RegExp('filename=(["\']?)([^\1]*)\1')
              .firstMatch(contentDisposition);
          if (match != null) {
            fileName = match.group(2)!;
          }
        }

        // Get the external storage directory
        final externalDir = await getExternalStorageDirectory();
        final filePath = '${externalDir!.path}/$fileName';

        // Save the downloaded file to external storage
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        final result = await OpenFile.open(filePath);

        if (result.type != ResultType.done) {
          print('Error opening file: ${result.message}');
        }
      } else {
        print('HTTP request error: ${response.statusCode}');
      }
    } on PlatformException catch (e) {
      print('PlatformException: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget openFile(url) {
    return FutureBuilder<void>(
      future: downloadAndOpenFile(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Function is still loading
          return InkWell(
            onTap: () {
              // User cannot tap while loading
            },
            child: const Text(
              'Opening file...',
              style:
                  TextStyle(color: Colors.grey), // Change to your desired style
            ),
          );
        } else if (snapshot.hasError) {
          // An error occurred
          return InkWell(
            onTap: () {
              // Handle error or retry logic
            },
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(
                  color: Colors.red), // Change to your desired style
            ),
          );
        } else {
          // Function has completed successfully
          return InkWell(
            onTap: () {
              // Handle successful completion
            },
            child: Text(
              'Open file',
              style: headLine2(blue),
            ),
          );
        }
      },
    );
  }
}
