import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:quick_medcare/widgets/info_textfield.dart';

import '../../firebase_reposisitories/cloud_firestore.dart';
import '../../utils/colors.dart';
import '../../utils/textstyle.dart';
import '../../widgets/main_button.dart';

class AddPatientDetails extends StatefulWidget {
  const AddPatientDetails({
    super.key,
  });

  @override
  State<AddPatientDetails> createState() => _AddPatientDetailsState();
}

class _AddPatientDetailsState extends State<AddPatientDetails> {
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final pastConditionsController = TextEditingController();
  final allergiesController = TextEditingController();
  final previousSurgeriesController = TextEditingController();
  final symptomsController = TextEditingController();
  final symptomDurationController = TextEditingController();
  final symptomSeverityController = TextEditingController();
  final diagnosisController = TextEditingController();
  final prescriptionController = TextEditingController();
  final surgicalProcedureController = TextEditingController();
  final testResultsController = TextEditingController();
  final imageReportsController = TextEditingController();
  FirestoreClass fireStore = FirestoreClass();
  bool isLoading = false;
  bool isUploaded = false;
  @override
  void dispose() {
    fullNameController.dispose();
    dobController.dispose();
    genderController.dispose();
    emailController.dispose();
    addressController.dispose();
    pastConditionsController.dispose();
    allergiesController.dispose();
    previousSurgeriesController.dispose();
    symptomsController.dispose();
    symptomDurationController.dispose();
    symptomSeverityController.dispose();
    diagnosisController.dispose();
    prescriptionController.dispose();
    surgicalProcedureController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
              )),
          title: Text(
            'Add Patient\'s Medical Info',
            style: headLine3(white),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InfoTextField(controller: fullNameController, hint: 'Full Name'),
              const SizedBox(height: 20),
              InfoTextField(controller: dobController, hint: 'DOB dd/mm/yy'),
              const SizedBox(height: 20),
              InfoTextField(controller: genderController, hint: 'Gender'),
              const SizedBox(height: 20),
              InfoTextField(controller: emailController, hint: 'Email'),
              const SizedBox(height: 20),
              InfoTextField(controller: addressController, hint: 'Address'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: pastConditionsController,
                  hint: 'Past Conditions'),
              const SizedBox(height: 20),
              InfoTextField(controller: allergiesController, hint: 'Allergies'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: previousSurgeriesController,
                  hint: 'Previous Surgeries'),
              const SizedBox(height: 20),
              InfoTextField(controller: symptomsController, hint: 'Symptoms'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: symptomDurationController,
                  hint: 'Symptoms Duration'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: symptomSeverityController,
                  hint: 'Symptom Severity'),
              const SizedBox(height: 20),
              InfoTextField(controller: diagnosisController, hint: 'Diagnosis'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: prescriptionController, hint: 'Prescription'),
              const SizedBox(height: 20),
              InfoTextField(
                  controller: surgicalProcedureController,
                  hint: 'Surgical Procedures'),
              const SizedBox(height: 20),
              MainButton(
                  onpressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    final uploadSuccess = await fireStore.addPatientDetails(
                        fullName: fullNameController.text.trim(),
                        dob: dobController.text.trim(),
                        gender: genderController.text.trim(),
                        email: emailController.text.trim(),
                        address: addressController.text.trim(),
                        pastConditions: pastConditionsController.text.trim(),
                        allergies: allergiesController.text.trim(),
                        previousSurgeries: previousSurgeriesController.text.trim(),
                        symptoms: symptomsController.text.trim(),
                        symptomDuration: symptomDurationController.text.trim(),
                        symptomSeverity: symptomSeverityController.text.trim(),
                        testResults: testResultsController.text.trim(),
                        imageReports: imageReportsController.text.trim(),
                        diagnosis: diagnosisController.text.trim(),
                        prescription: prescriptionController.text.trim(),
                        surgicalProcedure: surgicalProcedureController.text.trim());
                    if (uploadSuccess == 'Saved') {
                      setState(() {
                        isUploaded = true;
                        isLoading = false;
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PatientFile(uid: widget.uid,)));
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: blue,
                          content: Text(uploadSuccess,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16))));
                    }
                  },
                  height: 50,
                  width: double.maxFinite,
                  child: isLoading
                      ? LoadingAnimationWidget.inkDrop(color: white, size: 25)
                      : Text(
                          isUploaded ? 'Saved' : 'Submit',
                          style: headLine4(white),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
