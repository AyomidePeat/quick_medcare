class AppointmentModel {
  String doctor;
  String patient;
  String date;
  String time;
  String appointmentNote;
  String doctorUid;
  String patinetUid;

  AppointmentModel(
      {required this.doctor,
      required this.patient,
      required this.date,
      required this.time,
      required this.appointmentNote,
      required this.doctorUid,
      required this.patinetUid});

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor,
      'patient': patient,
      'date': date,
      'time': time,
      'appointmetNote': appointmentNote
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> map) {
    return AppointmentModel(
        doctor: map['doctor'] ?? '',
        patient: map['patient'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        appointmentNote: map['appointmentNote'] ?? '', doctorUid:  map['doctorUid']??'', patinetUid: map['patinetUid']??''
        );
  }
}
