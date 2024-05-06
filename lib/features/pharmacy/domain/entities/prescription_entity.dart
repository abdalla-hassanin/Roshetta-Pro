import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/drug_entity.dart';

class PrescriptionEntity {
  final String doctorId;
  final String doctorName;
  final String doctorImg;
  final String prescriptionId;
  final String doctorDate;
  final List<DrugEntity> drugModel;
  final Timestamp dateTime;

  PrescriptionEntity(
      {required this.doctorId,
      required this.doctorName,
      required this.doctorImg,
      required this.prescriptionId,
      required this.doctorDate,
      required this.drugModel,
      required this.dateTime});
}
