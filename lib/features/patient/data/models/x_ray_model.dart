import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';

class XRayModel extends XRayEntity {
  XRayModel({
    required super.doctorId,
    required super.doctorName,
    required super.doctorImg,
    required super.labName,
    required super.date,
    required super.xRayImg,
    required super.xRayTitle,
    required super.notes,
    required super.dateTime,
  });

  factory XRayModel.fromMap(Map<String, dynamic> map) {
    return XRayModel(
      doctorId: map['doctorId'],
      doctorName: map['doctorName'],
      doctorImg: map['doctorImg'],
      labName: map['labName'],
      date: map['date'],
      xRayImg: map['xRayImg'],
      xRayTitle: map['xRayTitle'],
      notes: map['notes'],
      dateTime: map['dateTime'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorImg': doctorImg,
      'labName': labName,
      'date': date,
      'xRayImg': xRayImg,
      'xRayTitle': xRayTitle,
      'notes': notes,
      'dateTime': dateTime,
    };
  }

}
