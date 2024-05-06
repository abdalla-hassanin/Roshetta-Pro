import 'dart:io';

import 'package:roshetta_pro/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';

class GetPatientByMobileNumberUseCase {
  final DoctorRepository _repository;

  GetPatientByMobileNumberUseCase(this._repository);

  Future<PatientEntity> call(String mobileNumber) async {
    return await _repository.getPatientByMobileNumber(mobileNumber);
  }
}

class GetDPatientPrescriptionsUseCase {
  final DoctorRepository _repository;

  GetDPatientPrescriptionsUseCase(this._repository);

  Future<List<PrescriptionEntity>> call(String patientId) async {
    return await _repository.getPatientPrescriptions(patientId);
  }
}

class GetDPatientXRaysUseCase {
  final DoctorRepository _repository;

  GetDPatientXRaysUseCase(this._repository);

  Future<List<XRayEntity>> call(String patientId) async {
    return await _repository.getPatientXRays(patientId);
  }
}

class GetDPatientMedicalHistoryUseCase {
  final DoctorRepository _repository;

  GetDPatientMedicalHistoryUseCase(this._repository);

  Future<List<MedicalHistoryEntity>> call(String patientId) async {
    return await _repository.getPatientMedicalHistory(patientId);
  }
}

class AddNewPrescriptionUseCase {
  final DoctorRepository _repository;

  AddNewPrescriptionUseCase(this._repository);

  Future<String> call(String patientId, PrescriptionModel prescription) async {
    return await _repository.addNewPrescription(patientId, prescription);
  }
}

class AddNewXRayUseCase {
  final DoctorRepository _repository;

  AddNewXRayUseCase(this._repository);

  Future<String> call(String patientId, XRayModel xRay) async {
    return await _repository.addNewXRay(patientId, xRay);
  }
}

class AddNewMedicalHistoryUseCase {
  final DoctorRepository _repository;

  AddNewMedicalHistoryUseCase(this._repository);

  Future<String> call(
      String patientId, MedicalHistoryModel medicalHistory) async {
    return await _repository.addNewMedicalHistory(patientId, medicalHistory);
  }
}

class XRayUploadImageToStorageUseCase {
  final DoctorRepository _repository;

  XRayUploadImageToStorageUseCase(this._repository);

  Future<String> call(File image, String patientId) async {
    return await _repository.xRayUploadImageToStorage(image, patientId);

  }
}
