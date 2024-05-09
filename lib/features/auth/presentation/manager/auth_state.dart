part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final String uId;

  SignInSuccess(this.uId);
}

class SignInError extends AuthState {
  final String error;

  SignInError(this.error);
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {
  final String state;

  SignOutSuccess(this.state);
}

class SignOutError extends AuthState {
  final String error;

  SignOutError(this.error);
}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String state;

  ForgotPasswordSuccess(this.state);
}

class ForgotPasswordError extends AuthState {
  final String error;

  ForgotPasswordError(this.error);
}

class EmptyPickedImage extends AuthState {}

class PickImageSuccess extends AuthState {}

class PickImageError extends AuthState {
  final String error;

  PickImageError(this.error);
}

class UploadImageToStorageLoading extends AuthState {}

class UploadImageToStorageSuccess extends AuthState {
  final String imageUrl;

  UploadImageToStorageSuccess(this.imageUrl);
}

class UploadImageToStorageError extends AuthState {
  final String error;

  UploadImageToStorageError(this.error);
}

class DoctorChangeSpecializationValueState extends AuthState {}

class DoctorSignUpLoading extends AuthState {}

class DoctorSignUpSuccess extends AuthState {
  final String state;

  DoctorSignUpSuccess(this.state);
}

class DoctorSignUpError extends AuthState {
  final String error;

  DoctorSignUpError(this.error);
}

class GetDoctorLoading extends AuthState {}

class GetDoctorSuccess extends AuthState {
  final DoctorEntity doctorEntity;

  GetDoctorSuccess(this.doctorEntity);
}

class GetDoctorError extends AuthState {
  final String error;

  GetDoctorError(this.error);
}

class PatientChangeGenderValue extends AuthState {}

class PatientChangeBloodValue extends AuthState {}

class PatientChangeHeightValue extends AuthState {}

class PatientChangeWeightValue extends AuthState {}

class PatientSignUpLoading extends AuthState {}

class PatientSignUpSuccess extends AuthState {
  final String state;

  PatientSignUpSuccess(this.state);
}

class PatientSignUpError extends AuthState {
  final String error;

  PatientSignUpError(this.error);
}

class GetPatientLoading extends AuthState {}

class GetPatientSuccess extends AuthState {
  final PatientEntity patientEntity;

  GetPatientSuccess(this.patientEntity);
}

class GetPatientError extends AuthState {
  final String error;

  GetPatientError(this.error);
}

class PharmacySignUpLoading extends AuthState {}

class PharmacySignUpSuccess extends AuthState {
  final String state;

  PharmacySignUpSuccess(this.state);
}

class PharmacySignUpError extends AuthState {
  final String error;

  PharmacySignUpError(this.error);
}

class GetPharmacyLoading extends AuthState {}

class GetPharmacySuccess extends AuthState {
  final PharmacyEntity pharmacyEntity;

  GetPharmacySuccess(this.pharmacyEntity);
}

class GetPharmacyError extends AuthState {
  final String error;

  GetPharmacyError(this.error);
}
