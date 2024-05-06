import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient/domain/repositories/patient_repository.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';

class GetPatientPrescriptionsUseCase {
  final PatientRepository _repository;

  GetPatientPrescriptionsUseCase(this._repository);

  Future<List<PrescriptionEntity>> call(String patientId) async {
    return await _repository.getPatientPrescriptions(patientId);
  }
}

class GetPatientXRaysUseCase {
  final PatientRepository _repository;

  GetPatientXRaysUseCase(this._repository);

  Future<List<XRayEntity>> call(String patientId) async {
    return await _repository.getPatientXRays(patientId);
  }
}

class GetPatientMedicalHistoryUseCase {
  final PatientRepository _repository;

  GetPatientMedicalHistoryUseCase(this._repository);

  Future<List<MedicalHistoryEntity>> call(String patientId) async {
    return await _repository.getPatientMedicalHistory(patientId);
  }
}
