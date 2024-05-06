import 'package:roshetta_pro/features/patient/data/data_sources/patient_data_source.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient/domain/repositories/patient_repository.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDataSource _dataSource;

  PatientRepositoryImpl(this._dataSource);

  @override
  Future<List<MedicalHistoryEntity>> getPatientMedicalHistory(String patientId) async {
    return await _dataSource.getPatientMedicalHistory(patientId);
  }

  @override
  Future<List<PrescriptionEntity>> getPatientPrescriptions(String patientId) async {
    return await _dataSource.getPatientPrescriptions(patientId);
  }

  @override
  Future<List<XRayEntity>> getPatientXRays(String patientId) async {
    return await _dataSource.getPatientXRays(patientId);
  }
}
