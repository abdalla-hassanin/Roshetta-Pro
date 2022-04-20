import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalHistoryModel {
  MedicalHistoryModel({
    required this.doctorId,
    required this.doctorName,
    required this.doctorImg,
    required this.date,
    required this.body,
    required this.dateTime,
  });
  late final String doctorId;
  late final String doctorName;
  late final String doctorImg;
  late final String date;
  late final String body;
  late final FieldValue dateTime;

  MedicalHistoryModel.fromJson(Map<String, dynamic> json){
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    doctorImg = json['doctorImg'];
    date = json['date'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['doctorId'] = doctorId;
    _data['doctorName'] = doctorName;
    _data['doctorImg'] = doctorImg;
    _data['date'] = date;
    _data['body'] = body;
    _data['dateTime'] = dateTime;

    return _data;
  }
}
