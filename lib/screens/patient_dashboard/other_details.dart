import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quick_medcare/firebase_reposisitories/cloud_firestore.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/info_textField.dart';
import 'package:quick_medcare/widgets/main_button.dart';

class OtherDetailsScreen extends StatefulWidget {
  const OtherDetailsScreen({super.key});

  @override
  State<OtherDetailsScreen> createState() => _OtherDetailsScreenState();
}

class _OtherDetailsScreenState extends State<OtherDetailsScreen> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final cholesterolController = TextEditingController();
  final healthAgencyController = TextEditingController();
  final bloodTypeController = TextEditingController();
  final genotypeController = TextEditingController();
  final bloodPressureController = TextEditingController();
  final treatmentController = TextEditingController();

  FirestoreClass fireStore = FirestoreClass();
  bool isLoading = false;
   bool isUploaded=false;
  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    heightController.dispose();
    cholesterolController.dispose();
    healthAgencyController.dispose();
    bloodTypeController.dispose();
    bloodPressureController.dispose();
    genotypeController.dispose();
    treatmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OtherInfoModel otherDetails = OtherInfoModel(
        age: ageController.text,
        weight: weightController.text,
        height: heightController.text,
        cholesterol: cholesterolController.text,
        healthAgency: healthAgencyController.text,
        bloodType: bloodTypeController.text,
        genotype: genotypeController.text,
        bloodPressure: bloodPressureController.text);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
              )),
          title: Text(
            'Medical Info',
            style: headLine4(white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoTextField(
                controller: ageController,
                hint: 'Your age',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: heightController,
                hint: 'Height in ft',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: weightController,
                hint: 'Weight in kg',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: healthAgencyController,
                hint: 'Health Insurance Agency',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: bloodTypeController,
                hint: 'Blood Type',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: genotypeController,
                hint: 'Genotype',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: cholesterolController,
                hint: 'Cholesterol',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: bloodPressureController,
                hint: 'Blood Pressure',
              ),
              const SizedBox(height: 20),
              InfoTextField(
                controller: treatmentController,
                hint: 'What treatment have you received previously?',
              ),
              const SizedBox(height: 20),
              MainButton(
                  onpressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool uploadSuccess = await fireStore.addUserDetails(
                        otherDetails: otherDetails);
                    if (uploadSuccess) {
                      setState(() {
                        isUploaded = true;
                         isLoading = false;

                      });
                    }
                  },
                  height: 50,
                  width: double.maxFinite,
                  child: isLoading
                      ? LoadingAnimationWidget.inkDrop(color: white, size: 25)
                      : Text(
                         isUploaded? 'Thank you' :'Submit',
                          style: headLine4(white),
                        ))
            ],
          ),
        ),
      ),
    );
  }
}
