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

  factory PatientDetailsModel.getModelFromJson({ Map<String, dynamic>? json}) {
    return PatientDetailsModel(
       firstName: json!['firstName'],
        gender: json['gender'],
        lastName: json['lastName']
        );
  }
}
class OtherInfoModel {
  final String firstname;
  final String lastname;
  final int age;
  final double weight;
  final double height;
  final double cholesterol;
  final String gender;
  final String healthAgency;
  final String bloodType;
  final String genotype;
  final double bloodPressure;

  OtherInfoModel({
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.weight,
    required this.height,
    required this.cholesterol,
    required this.gender,
    required this.healthAgency,
    required this.bloodType,
    required this.genotype,
    required this.bloodPressure,
   
   
    //  this.id,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstname,
        'lastName': lastname,
        'age': age,
        'weight': weight,
        'height': height,
        'cholesterol': cholesterol,
        'gender': gender,
        'healthAgency': healthAgency,
        'bloodType': bloodType,
        'genotype': genotype,
        'bloodPressure': bloodPressure
      };

  factory OtherInfoModel.getModelFromJson({required Map<String, dynamic> json}) {
    return OtherInfoModel(
        age: json['age'],
        bloodPressure: json['bloodPressure'],
        height:json ['height'],
        cholesterol: json['cholesterol'],
        firstname: json['firstName'],
        healthAgency: json['healthAgency'],
        gender: json['gender'],
        weight: json['weight'],
        bloodType: json['bloodType'],
        genotype: json['genotype'],
        lastname: json['lastName']);
  }
}
