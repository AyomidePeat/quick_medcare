import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';

import '../../utils/colors.dart';
import '../../utils/textstyle.dart';
import '../../utils/upload_image.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final image;
  final String name;
  final String gender;
  final String id;
  const ProfileScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.gender,
      required this.id});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

XFile? _imageFile;
ImageUpload imageUpload = ImageUpload();
bool isImageLoading = false;

bool isImageGood() {
  return _imageFile != null;
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final firestoreRef = ref.watch(cloudStoreProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
              child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: grey,
                radius: 50,
                backgroundImage: _imageFile == null
                    ? NetworkImage(widget.image) as ImageProvider<Object>?
                    : FileImage(File(_imageFile!.path)),
              ),
              Positioned(
                bottom: 9,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    imageUpload.uploadImage(context, (pickedImg) {
                      setState(() {
                        _imageFile = pickedImg;
                      });
                     final pickedImageFile = convertXFileToFile(pickedImg);
firestoreRef.uploadImageToFirestore(pickedImageFile);

                    });
                  },
                  child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: blue,
                        ),
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      child: const Icon(Icons.edit, size: 20)),
                ),
              )
            ],
          )),
          const SizedBox(height: 10),
          Text(
            widget.name,
            style: headLine3(black),
          ),
          Text(
            ' ID: ${widget.id}',
            style: bodyText4(black),
          ),
          Text(
            widget.gender,
            style: bodyText4(black),
          )
        ],
      ),
    );
  }
  File convertXFileToFile(XFile xFile) {
  final filePath = xFile.path;
  return File(filePath);
}
}
