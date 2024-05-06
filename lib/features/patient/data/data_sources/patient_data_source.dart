import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';

class PatientDataSource {
  Future<List<PrescriptionModel>> getPatientPrescriptions(
      String patientId) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.prescriptions)
          .orderBy(FireBaseEndPoints.dateTime, descending: true)
          .get();
      if (userQuery.docs.isEmpty) {
        return [];
      }
      return userQuery.docs
          .map((doc) => PrescriptionModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MedicalHistoryModel>> getPatientMedicalHistory(
      String patientId) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.medicalHistory)
          .orderBy(FireBaseEndPoints.dateTime, descending: true)
          .get();
      if (userQuery.docs.isEmpty) {
        return [];
      }
      return userQuery.docs
          .map((doc) => MedicalHistoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<XRayModel>> getPatientXRays(String patientId) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.xrays)
          .orderBy(FireBaseEndPoints.dateTime, descending: true)
          .get();

      if (userQuery.docs.isEmpty) {
        return [];
      }

      return userQuery.docs
          .map((doc) => XRayModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
