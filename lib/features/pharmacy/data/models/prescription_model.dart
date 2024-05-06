import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roshetta_pro/features/pharmacy/data/models/drug_model.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';

class PrescriptionModel extends PrescriptionEntity {
  PrescriptionModel({
    required super.doctorId,
    required super.doctorName,
    required super.doctorImg,
    required super.prescriptionId,
    required super.doctorDate,
    required List<DrugModel> super.drugModel,
    required super.dateTime,
  });

  factory PrescriptionModel.fromMap(Map<String, dynamic> map) {
    List<DrugModel> drugs = [];
    if (map['drugModel'] != null) {
      map['drugModel'].forEach((v) {
        drugs.add(DrugModel.fromMap(v));
      });
    }
    return PrescriptionModel(
      doctorId: map['doctorId'],
      doctorName: map['doctorName'],
      doctorImg: map['doctorImg'],
      prescriptionId: map['prescriptionId'],
      doctorDate: map['doctorDate'],
      drugModel: drugs,
      dateTime: map['dateTime']
    );
  }
}
