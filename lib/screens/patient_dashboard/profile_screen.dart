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
  final String email;
  const ProfileScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.gender,
      required this.email,
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

String email = '';
String age = '';
String cholesterol = '';
String healthAgency = '';
String bloodType = '';
String bloodPressure = '';
String genotype = '';
String height = '';
String weight = '';

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final firestoreRef = ref.watch(cloudStoreProvider);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: blue,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: grey,
                      radius: 40,
                      backgroundImage: _imageFile == null
                          ? NetworkImage(widget.image) as ImageProvider<Object>?
                          : FileImage(File(_imageFile!.path)),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 13,
                      child: GestureDetector(
                        onTap: () {
                          imageUpload.uploadImage(context, (pickedImg) {
                            setState(() {
                              _imageFile = pickedImg;
                            });
                            final pickedImageFile =
                                convertXFileToFile(pickedImg);
                            firestoreRef
                                .uploadImageToFirestore(pickedImageFile);
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
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: headLine2(white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            ' ID: ${widget.id}',
                            style: bodyText4(white),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            widget.gender,
                            style: bodyText4(white),
                          ),
                        ],
                      ),
                        Text(
                            widget.email,
                            style: bodyText4(grey),
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Medical Info',
              style: headLine3(black),
            ),
            StreamBuilder(
                stream: firestoreRef.getUserDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(color: blue);
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final userDetails = snapshot.data!;
                    int i = 0;
                    age = userDetails[i].age;
                    weight = userDetails[i].weight;
                    bloodPressure = userDetails[i].bloodPressure;
                    bloodType = userDetails[i].bloodType;
                    height = userDetails[i].height;
                    healthAgency = userDetails[i].healthAgency;
                    cholesterol = userDetails[i].cholesterol;
                    genotype = userDetails[i].genotype;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Age',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '$age years',
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                        Text(
                          'Weight',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '$weight Kg',
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                        Text(
                          'Blood Pressure',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '$bloodPressure mmHg',
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                        Text(
                          'Cholesterol',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '$cholesterol ft',
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                        Text(
                          'Genotype',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          genotype,
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                        Text(
                          'Health Insurance Agency',
                          style: headLine3(black),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          healthAgency,
                          style: bodyText4(black),
                        ),
                        const DividerWidget(),
                      ],
                    );
                  } else {
                    final error = snapshot.error.toString();
                    print(error);
                    return Center(
                      child: Text(error),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  File convertXFileToFile(XFile xFile) {
    final filePath = xFile.path;
    return File(filePath);
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Divider(
          color: grey,
          thickness: 3,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
