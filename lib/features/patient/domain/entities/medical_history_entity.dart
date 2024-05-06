import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalHistoryEntity {
  final String doctorId;
  final String doctorName;
  final String doctorImg;
  final String date;
  final String body;
  final Timestamp dateTime;

  MedicalHistoryEntity({
    required this.doctorId,
    required this.doctorName,
    required this.doctorImg,
    required this.date,
    required this.body,
    required this.dateTime,
  });
}
