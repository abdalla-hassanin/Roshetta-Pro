part of 'doctor_cubit.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class AddDrugToListSuccess extends DoctorState {
  final List<DrugEntity> drugs;

  AddDrugToListSuccess(this.drugs);
}

class GetPatientByMobileNumberLoading extends DoctorState {}

class GetPatientByMobileNumberSuccess extends DoctorState {
  final PatientEntity patientEntity;

  GetPatientByMobileNumberSuccess(this.patientEntity);
}

class GetPatientByMobileNumberError extends DoctorState {
  final String error;

  GetPatientByMobileNumberError(this.error);
}

class GetPatientPrescriptionsLoading extends DoctorState {}

class GetPatientPrescriptionsSuccess extends DoctorState {
  final List<PrescriptionEntity> patientPrescriptions;

  GetPatientPrescriptionsSuccess(this.patientPrescriptions);
}

class GetPatientPrescriptionsError extends DoctorState {
  final String error;

  GetPatientPrescriptionsError(this.error);
}

class GetPatientXRaysLoading extends DoctorState {}

class GetPatientXRaysSuccess extends DoctorState {
  final List<XRayEntity> patientXRays;

  GetPatientXRaysSuccess(this.patientXRays);
}

class GetPatientXRaysError extends DoctorState {
  final String error;

  GetPatientXRaysError(this.error);
}

class GetPatientMedicalHistoryLoading extends DoctorState {}

class GetPatientMedicalHistorySuccess extends DoctorState {
  final List<MedicalHistoryEntity> patientMedicalHistory;

  GetPatientMedicalHistorySuccess(this.patientMedicalHistory);
}

class GetPatientMedicalHistoryError extends DoctorState {
  final String error;

  GetPatientMedicalHistoryError(this.error);
}

class AddNewPrescriptionLoading extends DoctorState {}

class AddNewPrescriptionSuccess extends DoctorState {
  final String state;

  AddNewPrescriptionSuccess(this.state);
}

class AddNewPrescriptionError extends DoctorState {
  final String error;

  AddNewPrescriptionError(this.error);
}

class AddNewXRayLoading extends DoctorState {}

class AddNewXRaySuccess extends DoctorState {
  final String state;

  AddNewXRaySuccess(this.state);
}

class AddNewXRayError extends DoctorState {
  final String error;

  AddNewXRayError(this.error);
}

class AddNewMedicalHistoryLoading extends DoctorState {}

class AddNewMedicalHistorySuccess extends DoctorState {
  final String state;

  AddNewMedicalHistorySuccess(this.state);
}

class AddNewMedicalHistoryError extends DoctorState {
  final String error;

  AddNewMedicalHistoryError(this.error);
}

class XRayUploadImageToStorageLoading extends DoctorState {}

class XRayUploadImageToStorageSuccess extends DoctorState {
  final String imageUrl;

  XRayUploadImageToStorageSuccess(this.imageUrl);
}

class XRayUploadImageToStorageError extends DoctorState {
  final String error;

  XRayUploadImageToStorageError(this.error);
}
