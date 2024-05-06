import 'package:cloud_firestore/cloud_firestore.dart';

class XRayEntity {
  final String doctorId;
  final String doctorName;
  final String doctorImg;
  final String labName;
  final String date;
  final String xRayImg;
  final String xRayTitle;
  final String notes;
  final Timestamp dateTime;

  XRayEntity({
    required this.doctorId,
    required this.doctorName,
    required this.doctorImg,
    required this.labName,
    required this.date,
    required this.xRayImg,
    required this.xRayTitle,
    required this.notes,
    required this.dateTime,
  });
}
