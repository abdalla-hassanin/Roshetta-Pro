import 'package:cloud_firestore/cloud_firestore.dart';

import 'drug_model.dart';

class PrescriptionModel {
  PrescriptionModel({
    required this.doctorId,
    required this.doctorName,
    required this.doctorImg,
    required this.prescriptionId,
    required this.doctorDate,
    required this.drugModel,
    required this.dateTime,

  });
  late final String doctorId;
  late final String doctorName;
  late final String doctorImg;
  late final String prescriptionId;
  late final String doctorDate;
  late final List<DrugModel> drugModel;
  late final FieldValue dateTime;

  PrescriptionModel.fromJson(Map<String, dynamic> json){
    doctorId = json['doctorId'];
    doctorName = json['doctorName'];
    doctorImg = json['doctorImg'];
    prescriptionId = json['prescriptionId'];
    doctorDate = json['doctorDate'];
    drugModel = List.from(json['drugModel']).map((e)=>DrugModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['doctorId'] = doctorId;
    _data['doctorName'] = doctorName;
    _data['doctorImg'] = doctorImg;
    _data['prescriptionId'] = prescriptionId;
    _data['doctorDate'] = doctorDate;
    _data['drugModel'] = drugModel.map((e)=>e.toJson()).toList();
    _data['dateTime'] = dateTime;

    return _data;
  }
}
