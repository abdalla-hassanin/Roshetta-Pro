import 'dart:io';

import 'package:roshetta_pro/features/doctor/data/data_sources/doctor_data_source.dart';
import 'package:roshetta_pro/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorDataSource _dataSource;

  DoctorRepositoryImpl(this._dataSource);

  @override
  Future<PatientEntity> getPatientByMobileNumber(String mobileNumber) async {
    return await _dataSource.getPatientByMobileNumber(mobileNumber);
  }

  @override
  Future<List<PrescriptionEntity>> getPatientPrescriptions(
      String patientId) async {
    return await _dataSource.getPatientPrescriptions(patientId);
  }

  @override
  Future<List<MedicalHistoryEntity>> getPatientMedicalHistory(
      String patientId) async {
    return await _dataSource.getPatientMedicalHistory(patientId);
  }

  @override
  Future<List<XRayEntity>> getPatientXRays(String patientId) async {
    return await _dataSource.getPatientXRays(patientId);
  }

  @override
  Future<String> addNewMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory) async {
    return await _dataSource.addNewMedicalHistory(patientId, medicalHistory);
  }

  @override
  Future<String> addNewPrescription(
      String patientId, PrescriptionModel prescription) async {
    return await _dataSource.addNewPrescription(patientId, prescription);
  }

  @override
  Future<String> addNewXRay(String patientId, XRayModel xRay) async {
    return await _dataSource.addNewXRay(patientId, xRay);
  }

  @override
  Future<String> xRayUploadImageToStorage(File image, String patientId) async {
    return await _dataSource.xRayUploadImageToStorage(image, patientId);
  }
}
