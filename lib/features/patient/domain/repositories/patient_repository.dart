import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';

abstract class PatientRepository {
  //TODO: Add methods to get all patient details in one call
  //TODO: Future<PatientDetailsEntity> getPatientDetails();

  Future<List<PrescriptionEntity>> getPatientPrescriptions(String patientId);
  Future<List<XRayEntity>> getPatientXRays(String patientId);
  Future<List<MedicalHistoryEntity>> getPatientMedicalHistory(String patientId);

}
