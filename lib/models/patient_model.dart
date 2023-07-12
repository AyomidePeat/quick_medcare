class PatientDetailsModel {
  final String firstName;
  final String lastName;
  final String gender;

  PatientDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.gender,

    //  this.id,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
      };

  factory PatientDetailsModel.getModelFromJson({Map<String, dynamic>? json}) {
    return PatientDetailsModel(
        firstName: json!['firstName'],
        gender: json['gender'],
        lastName: json['lastName']);
  }
}

class OtherInfoModel {
  final String age;
  final String weight;
  final String height;
  final String cholesterol;

  final String healthAgency;
  final String bloodType;
  final String genotype;
  final String bloodPressure;

  OtherInfoModel({
    required this.age,
    required this.weight,
    required this.height,
    required this.cholesterol,
    required this.healthAgency,
    required this.bloodType,
    required this.genotype,
    required this.bloodPressure,

    //  this.id,
  });

  Map<String, dynamic> toJson() => {
        'age': age,
        'weight': weight,
        'height': height,
        'cholesterol': cholesterol,
        'healthAgency': healthAgency,
        'bloodType': bloodType,
        'genotype': genotype,
        'bloodPressure': bloodPressure
      };

  factory OtherInfoModel.getModelFromJson(Map<String, dynamic> json) {
    return OtherInfoModel(
      age: json['age'],
      bloodPressure: json['bloodPressure'],
      height: json['height'],
      cholesterol: json['cholesterol'],
      healthAgency: json['healthAgency'],
      weight: json['weight'],
      bloodType: json['bloodType'],
      genotype: json['genotype'],
    );
  }
}
