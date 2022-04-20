import 'package:cloud_firestore/cloud_firestore.dart';

class XRaysAnalysisModel {
  XRaysAnalysisModel({
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
  late final String doctorId;
  late final String doctorName;
  late final String doctorImg;
  late final String labName;
  late final String date;
  late final String xRayImg;
  late final String xRayTitle;
  late final String notes;
  late final FieldValue dateTime;

  XRaysAnalysisModel.fromJson(Map<String, dynamic> json){
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    doctorImg = json['doctorImg'];
    labName = json['labName'];
    date = json['date'];
    xRayImg = json['xRayImg'];
    xRayTitle = json['xRayTitle'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['doctorId'] = doctorId;
    _data['doctorName'] = doctorName;
    _data['doctorImg'] = doctorImg;
    _data['labName'] = labName;
    _data['date'] = date;
    _data['xRayImg'] = xRayImg;
    _data['xRayTitle'] = xRayTitle;
    _data['notes'] = notes;
    _data['dateTime'] = dateTime;

    return _data;
  }
}
