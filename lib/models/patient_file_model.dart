class PatientFileModel {
  final String fullName;
  final String dob;
  final String gender;
  final String email;
  final String address;
  final String pastConditions;
  final String allergies;
  final String previousSurgeries;
  final String symptoms;
  final String symptomDuration;
  final String symptomSeverity;
  var testResults;
  var imageReports;
  final String diagnosis;
  final String prescription;
  final String surgicalProcedure;

  PatientFileModel(
      {required this.fullName,
      required this.dob,
      required this.gender,
      required this.email,
      required this.address,
      required this.pastConditions,
      required this.allergies,
      required this.previousSurgeries,
      required this.symptoms,
      required this.symptomDuration,
      required this.symptomSeverity,
      required this.testResults,
      required this.imageReports,
      required this.diagnosis,
      required this.prescription,
      required this.surgicalProcedure});

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'dob': dob,
        'gender': gender,
        'email': email,
        'address': address,
        'pastConditions': pastConditions,
        'allergies': allergies,
        'previousSurgeries': previousSurgeries,
        'symptoms': previousSurgeries,
        'symptomDuration': previousSurgeries,
        'symptomSeverity': previousSurgeries,
        'testResults': testResults,
        'imageReports': imageReports,
        'diagnosis': diagnosis,
        'prescription': prescription,
        'surgicalProcedure': surgicalProcedure,
      };

  factory PatientFileModel.getModelFromJson(Map<String, dynamic> json) {
    return PatientFileModel(
      address: json['address'],
      allergies: json['allergies'],
      diagnosis: json['diagnosis'],
      dob: json['dob'],
      email: json['email'],
      testResults: json['testResults'],
      fullName: json['fullName'],
      imageReports: json['imageReports'],
      surgicalProcedure: json['surgicalProcedure'],
      gender: json['gender'],
      symptomDuration: json['symptomDuration'],
      prescription: json['prescription'],
      previousSurgeries: json['previousSurgeries'],
      symptoms: json['symptoms'],
      symptomSeverity: json['symptomSeverity'],
      pastConditions: json['pastConditions'],
    );
  }
}
