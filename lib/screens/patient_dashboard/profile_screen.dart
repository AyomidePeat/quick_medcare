import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../utils/colors.dart';
import '../../utils/textstyle.dart';
import '../../utils/upload_image.dart';
import 'other_details.dart';

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
String condition = 'normal';
bool isImageGood() {
  return _imageFile != null;
}

late String email;
late String age;
late String cholesterol;
late String healthAgency;
late String bloodType;
late String bloodPressure;
late String genotype;
late String height;
late String weight;
late num bmi;

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
            padding: const EdgeInsets.symmetric(vertical:30.0, horizontal: 22),
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
                      const SizedBox(height: 10,),

                      Text(
                        widget.name,
                        style: headLine2(white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.gender,
                        style: bodyText4(white),
                      ),
                      const SizedBox(height: 5),
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
        child: SingleChildScrollView(
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
                    } else {
                      final userDetails = snapshot.data!;
                      if (userDetails.isNotEmpty) {
                        int i = 0;
                        age = userDetails[i].age;
                        weight = userDetails[i].weight;
                        bloodPressure = userDetails[i].bloodPressure;
                        bloodType = userDetails[i].bloodType;
                        height = userDetails[i].height;
                        healthAgency = userDetails[i].healthAgency;
                        cholesterol = userDetails[i].cholesterol;
                        genotype = userDetails[i].genotype;

                        bmi = num.parse(weight) / pow(int.parse(height), 2);
                        if (bmi < 18.5) {
                          condition = 'Underweight';
                        } else if (bmi >= 18.5 && bmi <= 24.9) {
                          condition = 'Normal Weight';
                        } else if (bmi >= 25.0 && bmi <= 29.9) {
                          condition = 'Overweight';
                        } else if (bmi > 30) {
                          condition = 'Obesity';
                        }
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 100),
                              Image.asset('images/record.png'),
                              const SizedBox(height: 10),
                              const Text(
                                  'You have not completed your registration'),
                              const SizedBox(height: 10),
                              MainButton(
                                  onpressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OtherDetailsScreen()));
                                  },
                                  height: 40,
                                  width: 160,
                                  child: Text(
                                    'Complete Now',
                                    style: headLine4(white),
                                  ))
                            ],
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'BMI',
                            style: headLine3(black),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${bmi.toStringAsFixed(2)}  ($condition)',
                            style: bodyText4(black),
                          ),
                          const DividerWidget(),
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
                            'Height',
                            style: headLine3(black),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '$height m',
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
                            'Blood Type',
                            style: headLine3(black),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            bloodType,
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
                    }
                  })
            ],
          ),
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
