class IllnessHistoryModel {
  final String illness;
  final String treatmentMode;
  final String date;

  IllnessHistoryModel({required this.illness, required this.treatmentMode, required this.date});

  Map<String, dynamic> toJson() => {
        'illness': illness,
        'treatmentMode': treatmentMode,
        'date': date,
       
      };

  factory IllnessHistoryModel.getModelFromJson(Map<String, dynamic> json) {
    return IllnessHistoryModel(
      illness: json['illness'],
        treatmentMode: json['treatmentMode'],
        date: json['date'],
      );
  }
}
