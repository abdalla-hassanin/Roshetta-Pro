import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';

class MedicalHistoryModel extends MedicalHistoryEntity {
  MedicalHistoryModel({
    required super.doctorId,
    required super.doctorName,
    required super.doctorImg,
    required super.date,
    required super.body,
    required super.dateTime,
  });

  factory MedicalHistoryModel.fromMap(Map<String, dynamic> map) {
    return MedicalHistoryModel(
      doctorId: map['doctorId'],
      doctorName: map['doctorName'],
      doctorImg: map['doctorImg'],
      date: map['date'],
      body: map['body'],
      dateTime: map['dateTime'] ,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorImg': doctorImg,
      'date': date,
      'body': body,
      'dateTime': dateTime,
    };
  }

}
