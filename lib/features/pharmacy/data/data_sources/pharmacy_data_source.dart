import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/pharmacy/data/models/prescription_model.dart';

class PharmacyDataSource {
  Future<PrescriptionModel> getPrescriptionByUserPhoneAndPrescriptionId(
      String mobilePhone, String prescriptionId) async {
    final userQuery = await FirebaseFirestore.instance
        .collection(FireBaseEndPoints.users)
        .where(FireBaseEndPoints.mobileNumber, isEqualTo: mobilePhone)
        .get();

    if (userQuery.docs.isEmpty) {
      throw Exception("User not found");
    }

    final userDoc = userQuery.docs.first;
    final prescriptionQuery = await userDoc.reference
        .collection(FireBaseEndPoints.prescriptions)
        .where(FireBaseEndPoints.prescriptionId, isEqualTo: prescriptionId)
        .get();

    if (prescriptionQuery.docs.isEmpty) {
      throw Exception("Prescription not found");
    }

    return PrescriptionModel.fromMap(prescriptionQuery.docs.first.data());
  }
}
