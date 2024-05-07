import 'dart:io';

import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';

abstract class DoctorRepository {
  Future<PatientEntity> getPatientByMobileNumber(String mobileNumber);

  Future<List<PrescriptionEntity>> getPatientPrescriptions(String patientId);

  Future<List<XRayEntity>> getPatientXRays(String patientId);

  Future<List<MedicalHistoryEntity>> getPatientMedicalHistory(String patientId);

  Future<String> addNewPrescription(
      String patientId, PrescriptionModel prescription);

  Future<String> addNewXRay(String patientId, XRayModel xRay);

  Future<String> addNewMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory);

  Future<String> xRayUploadImageToStorage(File image, String patientId);
}
