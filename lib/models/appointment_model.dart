class AppointmentModel {
  String doctor;
  String patient;
  String date;
  String time;
  String appointmentNote;
  String doctorUid;
  String patientUid;

  AppointmentModel(
      {required this.doctor,
      required this.patient,
      required this.date,
      required this.time,
      required this.appointmentNote,
      required this.doctorUid,
      required this.patientUid});

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'patient': patient,
      'date': date,
      'time': time,
      'appointmetNote': appointmentNote,
      'patientUid':patientUid,
      'doctorUid':doctorUid
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    return AppointmentModel(
        doctor: map['doctor'] ?? '',
        patient: map['patient'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        
        appointmentNote: map['appointmentNote'] ?? '', doctorUid:  map['doctorUid']??'', patientUid: map['patientUid']??''
        );
  }
}
