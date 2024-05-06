import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient_auth/data/models/patient_model.dart';

class DoctorDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<PatientModel> getPatientByMobileNumber(String mobileNumber) async {
    final userQuery = await firestore
        .collection(FireBaseEndPoints.users)
        .where(FireBaseEndPoints.mobileNumber, isEqualTo: mobileNumber)
        .get();

    if (userQuery.docs.isEmpty) {
      throw Exception("User not found");
    }
    return PatientModel.fromMap(userQuery.docs.first.data());
  }

  Future<List<PrescriptionModel>> getPatientPrescriptions(
      String patientId) async {
    try {
      final userQuery = await firestore
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
      final userQuery = await firestore
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
      final userQuery = await firestore
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

  Future<String> addNewPrescription(
      String patientId, PrescriptionModel prescription) async {
    try {
      await firestore
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.prescriptions)
          .add(prescription.toMap());

      return 'Prescription added successfully';
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Future<String> addNewXRay(String patientId, XRayModel xRay) async {
    try {
      await firestore
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.xrays)
          .add(xRay.toMap());
      return 'X-ray added successfully';
    } on FirebaseException catch (e) {
      await storage.refFromURL(xRay.xRayImg).delete();
      throw e.toString();
    }
  }

  Future<String> addNewMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory) async {
    try {
      await firestore
          .collection(FireBaseEndPoints.users)
          .doc(patientId)
          .collection(FireBaseEndPoints.medicalHistory)
          .add(medicalHistory.toMap());
      return 'Medical History added successfully';
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Future<String> xRayUploadImageToStorage(File image, String patientId) async {
    try {
      final ref = storage.ref().child(
          'users/xrayImages/$patientId/${DateTime.now().microsecondsSinceEpoch}${image.path.split('/').last}');
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }
}
