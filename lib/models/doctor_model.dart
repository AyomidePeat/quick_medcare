class DoctorDetailsModel {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;
  final String department;
  final String image;
  final String info;
  final String numberOfPatients;
  final String experience;
  final String role;

  DoctorDetailsModel(
      {required this.firstName,
      required this.lastName,
      required this.department,
      required this.email,
      required this.uid,
      required this.image,
      required this.info,
      required this.numberOfPatients,
      required this.experience,
      required this.role

      //  this.id,
      });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': uid,
        'department': department,
        'image': image,
        'info': info,
        'experience': experience,
        'numberOfPatients': numberOfPatients,
        'role': role
      };

  factory DoctorDetailsModel.getModelFromJson({Map<String, dynamic>? json}) {
    return DoctorDetailsModel(
        firstName: json!['firstName'],
        department: json['department'],
        email: json['email'],
        uid: json['uid'],
        image: json['image'],
        info: json['info'],
        numberOfPatients: json['numberOfPatients'],
        experience: json['experience'],
        role : json['role'],
        lastName: json['lastName']);
  }
}
