part of 'patient_cubit.dart';

abstract class PatientState {}

class PatientInitial extends PatientState {}

class GetPatientPrescriptionsLoading extends PatientState {}

class GetPatientPrescriptionsSuccess extends PatientState {
  final List<PrescriptionEntity> prescriptions;

  GetPatientPrescriptionsSuccess(this.prescriptions);
}

class GetPatientPrescriptionsError extends PatientState {
  final String error;

  GetPatientPrescriptionsError(this.error);
}

class GetPatientXRaysLoading extends PatientState {}

class GetPatientXRaysSuccess extends PatientState {
  final List<XRayEntity> xrays;

  GetPatientXRaysSuccess(this.xrays);
}

class GetPatientXRaysError extends PatientState {
  final String error;

  GetPatientXRaysError(this.error);
}

class GetPatientMedicalHistoryLoading extends PatientState {}

class GetPatientMedicalHistorySuccess extends PatientState {
  final List<MedicalHistoryEntity> medicalHistory;

  GetPatientMedicalHistorySuccess(this.medicalHistory);
}

class GetPatientMedicalHistoryError extends PatientState {
  final String error;

  GetPatientMedicalHistoryError(this.error);
}
