import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/info_textField.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../firebase_reposisitories/cloud_firestore.dart';
import '../../utils/upload_image.dart';

class AdminDashboard extends ConsumerStatefulWidget {
  const AdminDashboard({super.key});

  @override
  ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends ConsumerState<AdminDashboard> {
  XFile? _imageFile;
  ImageUpload imageUpload = ImageUpload();
  bool isImageLoading = false;
  bool isLoading = false;
  bool isUploaded = false;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController();
  final specializationController = TextEditingController();
  late File pickedImageFile;
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    uidController.dispose();
    specializationController.dispose();
    infoController.dispose();
    numberOfPatientsController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  void clear() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    uidController.clear();
    specializationController.clear();
    infoController.clear();
    numberOfPatientsController.clear();
    experienceController.clear();
  }

  bool isImageGood() {
    return _imageFile != null;
  }

  var department = 'General';

  final infoController = TextEditingController();
  final numberOfPatientsController = TextEditingController();
  final experienceController = TextEditingController();
  var image = 'images/userIcon.png';
  @override
  Widget build(BuildContext context) {
    final firestoreRef = ref.watch(cloudStoreProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'Add a Doctor',
          style: headLine2(white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  imageUpload.uploadImage(context, (pickedImg) {
                    setState(() {
                      _imageFile = pickedImg;
                    });

                    pickedImageFile = convertXFileToFile(pickedImg);
                  });
                },
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _imageFile == null
                        ? AssetImage(image) as ImageProvider<Object>?
                        : FileImage(File(_imageFile!.path)),
                    backgroundColor: blue,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(
                  controller: uidController,
                  hint: 'Uid(Copy this from firebase)'),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(
                  controller: firstNameController, hint: 'First name'),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(controller: lastNameController, hint: 'Last name'),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(controller: emailController, hint: 'E-mail'),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Select Department',
                    style: bodyText3(black),
                  ),
                  const SizedBox(width: 10),
                  selectDepartment(),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(
                  controller: specializationController, hint: 'Specialization'),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(controller: infoController, hint: 'Bio'),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(
                  controller: numberOfPatientsController,
                  hint: 'Number of Patients'),
              const SizedBox(
                height: 15,
              ),
              InfoTextField(
                  controller: experienceController,
                  hint: 'Years of experience(in figure)'),
              const SizedBox(
                height: 15,
              ),
              MainButton(
                  onpressed: !isUploaded
                      ? () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (uidController.text.isNotEmpty) {
                            final uploadSuccess = await firestoreRef.addDoctor(
                                specialization: specializationController.text,
                                uid: uidController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                department: department,
                                image: image,
                                info: infoController.text,
                                numberOfPatients:
                                    numberOfPatientsController.text,
                                experience: experienceController.text,
                                role: 'doctor');
                            setState(() {
                              firestoreRef.uploadDoctorsImageToFirestore(
                                  pickedImageFile, uidController.text,department);
                            });
                            if (uploadSuccess == 'Uploaded') {
                              setState(() {
                                isUploaded = true;
                                isLoading = false;
                              });
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: blue,
                                      content: Text(
                                          uploadSuccess,
                                          textAlign: TextAlign.center,
                                          style:
                                              const TextStyle(fontSize: 16))));
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: red,
                                content: const Text('Input the Uid',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ))));
                          }
                        }
                      : () {
                          clear();
                          setState(() {
                            isUploaded = false;
                          });
                        },
                  height: 40,
                  width: double.infinity,
                  child: isLoading
                      ? LoadingAnimationWidget.inkDrop(color: white, size: 25)
                      : Text(
                          isUploaded ? 'Done' : 'Submit',
                          style: headLine4(white),
                        )),
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

  Widget selectDepartment() {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 234, 234),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.all(10),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(5),
        hint: Text(
          'Select Department',
          style: bodyText4(black),
        ),
        dropdownColor: white,
        value: department,
        onChanged: (newValue) {
          setState(() {
            department = newValue!;
          });
        },
        items: <String>[
          'Dentistry',
          'Cardiology',
          'General',
          'Dermatology',
          'Gynaecology',
          'Neurology',
          'Opthalmology',
          'Radiology'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: bodyText3(black)),
          );
        }).toList(),
      ),
    );
  }
}
