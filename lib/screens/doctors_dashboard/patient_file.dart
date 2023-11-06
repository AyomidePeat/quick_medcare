import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_medcare/models/patient_file_model.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import '../../firebase_reposisitories/cloud_firestore.dart';
import '../../widgets/custom_container.dart';

late String email;
late String fullName;
final patientDetailsProvider = FutureProvider<PatientFileModel?>((ref) async {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  final result = await cloudStoreRef.getPatientFile(fullName, email);
  return result;
});

class PatientFile extends ConsumerStatefulWidget {
  final String uid;
  final String email;
  final String fullName;
  const PatientFile(
      {required this.uid,
      required this.email,
      required this.fullName,
      super.key});

  @override
  ConsumerState<PatientFile> createState() => _PatientFileState();
}

class _PatientFileState extends ConsumerState<PatientFile> {
  String dob = '';
  String gender = '';
  String receiverEmail = '';
  String address = '';
  String pastConditions = '';
  String allergies = '';
  String previousSurgeries = '';
  String symptoms = '';
  String symptomDuration = '';
  String symptomSeverity = '';
  var testResults = '';
  var imageReports = '';
  String diagnosis = '';
  String prescription = '';
  String surgicalProcedure = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fullName = widget.fullName;
    email = widget.email;
  }
final patientDetailsProvider = FutureProvider<PatientFileModel?>((ref) async {
  final cloudStoreRef = ref.read(cloudStoreProvider);
  final result = await cloudStoreRef.getPatientFile(fullName, email);
  return result;
});
  @override
  Widget build(BuildContext context) {
    final patientFileRef = ref.watch(patientDetailsProvider);
    //final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            'Medical Data',
            style: headLine1(black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(physics: BouncingScrollPhysics(),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              patientFileRef.when(
                  data: (data) {
                    if (data != null) {
                      fullName = data.fullName;
                      dob = data.dob;
                      gender = data.gender;
                      receiverEmail = data.email;
                      address = data.address;
                      pastConditions = data.pastConditions;
                      allergies = data.allergies;
                      previousSurgeries = data.previousSurgeries;
                      symptoms = data.symptoms;
                      symptomDuration = data.symptomDuration;
                      symptomSeverity = data.symptomSeverity;
                      var testResults = data.testResults;
                      var imageReports = data.imageReports;
                      diagnosis = data.diagnosis;
                      prescription = data.prescription;
                      surgicalProcedure = data.surgicalProcedure;
                      return Column(
                        children: [
                          PersonalInformation(
                            address: address,
                            dob: dob,
                            email: receiverEmail,
                            fullName: fullName,
                            gender: gender,
                          ),
                          const SizedBox(height: 30),
                          MedicalHistory(
                            allergies: allergies,
                            pastConditions: pastConditions,
                            previousSurgeries: previousSurgeries,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CurrentExamination(
                            diagnosis: diagnosis,
                            prescription: prescription,
                            surgicalProcedure: surgicalProcedure,
                            symptomDuration: symptomDuration,
                            symptomSeverity: symptomSeverity,
                            symptoms: symptoms,
                          ),
                        ],
                      );
                    } else {
                      return Text('No rrecord');
                    }
                  },
                  error: (error, stackTrace) => Text('$error'),
                  loading: () => Text('Loading')),
            ]),
          ),
        ));
  }
}

class PersonalInformation extends StatelessWidget {
  final String fullName;
  final String dob;
  final String gender;
  final String email;
  final String address;
  const PersonalInformation({
    super.key,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.email,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: blue,
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/note.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: Text(
                        'Personal Information',
                        style: headLine2(white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Full Name: ',
                  style: bodyText3(white),
                ),
                Text(fullName, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text(
                  'DOB:',
                  style: bodyText3(white),
                ),
                Text(dob, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText3(white)),
                Text(gender, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email:', style: bodyText3(white)),
                Text(email, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText3(white)),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headLine4(white))),
              ],
            ),
          ]),
        ));
  }
}

class MedicalHistory extends StatelessWidget {
  final String pastConditions;
  final String allergies;
  final String previousSurgeries;

  const MedicalHistory({
    super.key,
    required this.pastConditions,
    required this.allergies,
    required this.previousSurgeries,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: blue,
        height: 250,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/people.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Past Medical Conditions',
                      style: headLine2(white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Known Allergies: ', style: bodyText3(white)),
                Text(allergies, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Past conditions: ', style: bodyText3(white)),
                Text(pastConditions, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Previous Surgeries: ', style: bodyText3(white)),
                Text(previousSurgeries, style: headLine4(white)),
              ],
            ),
          ]),
        ));
  }
}

class CurrentExamination extends StatelessWidget {
  final String symptoms;
  final String symptomDuration;
  final String symptomSeverity;
  final String diagnosis;
  final String prescription;
  final String surgicalProcedure;
  const CurrentExamination({
    super.key,
    required this.symptoms,
    required this.symptomDuration,
    required this.symptomSeverity,
    required this.diagnosis,
    required this.prescription,
    required this.surgicalProcedure,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: blue,
        height: 400,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/more.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Current Examination and Treatment',
                      style: headLine2(white),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Symptoms: ', style: bodyText3(white)),
                Text(symptoms, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Symptom Duration: ', style: bodyText3(white)),
                Text(symptomDuration, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Symptom Severity: ', style: bodyText3(white)),
                Text(symptomSeverity, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Diagnosis: ', style: bodyText3(white)),
                Text(diagnosis, style: headLine4(white)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Prescription: ', style: bodyText3(white)),
                SizedBox(
                    width: 200,
                    child: Text(prescription,
                        overflow: TextOverflow.fade, style: headLine4(white))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Surgical Prrocedure: ', style: bodyText3(white)),
                SizedBox(
                    width: 200,
                    child: Text(surgicalProcedure,
                        overflow: TextOverflow.fade, style: headLine4(white))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
          ]),
        ));
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }
}
