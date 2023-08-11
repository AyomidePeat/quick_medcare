import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_medcare/chatting/chat_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import '../../firebase_reposisitories/cloud_firestore.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/main_button.dart';

class PatientFile extends ConsumerStatefulWidget {
  final String uid;
  const PatientFile({required this.uid, super.key});

  @override
  ConsumerState<PatientFile> createState() => _PatientFileState();
}

class _PatientFileState extends ConsumerState<PatientFile> {
  late int idNo;

  late final String fullName;
  late final String dob;
  late final String gender;
  late final String receiverEmail;
  late final String address;
  late final String pastConditions;
  late final String allergies;
  late final String previousSurgeries;
  late final String symptoms;
  late final String symptomDuration;
  late final String symptomSeverity;
  var testResults;
  var imageReports;
  late final String diagnosis;
  late final String prescription;
  late final String surgicalProcedure;
  @override
  Widget build(BuildContext context) {
    final firestoreRef = ref.watch(cloudStoreProvider);
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
            style: headLine4(black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              StreamBuilder(
                  stream: firestoreRef.getPatientDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(color: blue));
                    } else {
                      final patientDetails = snapshot.data!;
                      if (patientDetails.isNotEmpty) {
                        int i = 0;

                        fullName = patientDetails[i].fullName;
                        dob = patientDetails[i].dob;
                        gender = patientDetails[i].gender;
                        receiverEmail = patientDetails[i].email;
                        address = patientDetails[i].address;
                        pastConditions = patientDetails[i].pastConditions;
                        allergies = patientDetails[i].allergies;
                        previousSurgeries = patientDetails[i].previousSurgeries;
                        symptoms = patientDetails[i].symptoms;
                        symptomDuration = patientDetails[i].symptomDuration;
                        symptomSeverity = patientDetails[i].symptomSeverity;
                        diagnosis = patientDetails[i].diagnosis;
                        prescription = patientDetails[i].prescription;
                        surgicalProcedure = patientDetails[i].surgicalProcedure;
                      } else {}
                      return Column(
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                minRadius: 30,
                                backgroundImage:
                                    AssetImage('images/patient.jpg'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jane Doe',
                                    style: headLine4(black),
                                  ),
                                  Text(
                                    'Reg No: $idNo',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 12,
                                        color: Colors.black),
                                  ),
                                  const Text(
                                    'Registered February 25, 2019',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 9,
                                        color: Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
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
                          const SizedBox(
                            height: 30,
                          ),
                          MainButton(
                              height: 35,
                              width: double.infinity,
                              onpressed: () {
                                // Navigator.push(
                                //     context,
                                  //  MaterialPageRoute(
                                        // builder: (context) => ChatScreen(
                                        //     receiverUserEmail: receiverEmail,
                                        //     userType: 'doctor',
                                        //     receiverUserId: receiverId,
                                        //     image: widget.image,
                                        //     receiverName: widget.receiverName,
                                        //     senderName: widget.senderName,
                                        //     senderEmail: widget.senderEmail)
                                        //)
                                       // );
                              },
                              child: Text(
                                'Continue to Chat',
                                style: bodyText3(black),
                              )),
                        ],
                      );
                    }
                  })
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
        color: lightBlue,
        height: 500,
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
                    Text(
                      'Personal Information',
                      style: headLine3(black),
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
                  style: bodyText3(black),
                ),
                Text(fullName, style: headLine4(black)),
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
                  style: bodyText3(black),
                ),
                Text(dob, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText3(black)),
                Text(gender, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email:', style: bodyText3(black)),
                Text(email, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText3(black)),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headLine4(black))),
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
        color: lightBlue,
        height: 300,
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
                      style: headLine3(black),
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
                Text('Known Allergies: ', style: bodyText3(black)),
                Text(allergies, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Past conditions: ', style: bodyText3(black)),
                Text(pastConditions, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Previous Surgeries: ', style: bodyText3(black)),
                Text(previousSurgeries, style: headLine4(black)),
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
        color: lightBlue,
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
                    SvgPicture.asset('images/more.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Current Examination and Treatment',
                      style: headLine3(black),
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
                Text('Symptoms: ', style: bodyText3(black)),
                Text(symptoms, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Symptom Duration: ', style: bodyText3(black)),
                Text(symptomDuration, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Symptom Severity: ', style: bodyText3(black)),
                Text(symptomSeverity, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Diagnosis: ', style: bodyText3(black)),
                Text(diagnosis, style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Prescription: ', style: bodyText3(black)),
                SizedBox(
                    width: 200,
                    child: Text(prescription,
                        overflow: TextOverflow.fade, style: headLine4(black))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Surgical Prrocedure: ', style: bodyText3(black)),
                SizedBox(
                    width: 200,
                    child: Text(surgicalProcedure,
                        overflow: TextOverflow.fade, style: headLine4(black))),
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
