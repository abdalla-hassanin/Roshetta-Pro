part of 'patient_auth_cubit.dart';

abstract class PatientAuthState {}

 class PatientAuthInitial extends PatientAuthState {}

class PatientChangeGenderValue extends PatientAuthState {}
class PatientChangeBloodValue extends PatientAuthState {}
class PatientChangeHeightValue extends PatientAuthState {}
class PatientChangeWeightValue extends PatientAuthState {}


class PatientSignInLoading extends PatientAuthState {}

class PatientSignInSuccess extends PatientAuthState {
  final String uId;
  PatientSignInSuccess(this.uId);
}

class PatientSignInError extends PatientAuthState {
  final String error;
  PatientSignInError(this.error);
}

class PatientSignUpLoading extends PatientAuthState {}

class PatientSignUpSuccess extends PatientAuthState {
  final String state;
  PatientSignUpSuccess(this.state);
}

class PatientSignUpError extends PatientAuthState {
  final String error;
  PatientSignUpError(this.error);
}

class PatientUploadImageToStorageLoading extends PatientAuthState {}

class PatientUploadImageToStorageSuccess extends PatientAuthState {
  final String imageUrl;
  PatientUploadImageToStorageSuccess(this.imageUrl);
}

class PatientUploadImageToStorageError extends PatientAuthState {
  final String error;
  PatientUploadImageToStorageError(this.error);
}

class PatientSignOutLoading extends PatientAuthState {}

class PatientSignOutSuccess extends PatientAuthState {
  final String state;
  PatientSignOutSuccess(this.state);
}

class PatientSignOutError extends PatientAuthState {
  final String error;
  PatientSignOutError(this.error);
}

class PatientForgotPasswordLoading extends PatientAuthState {}

class PatientForgotPasswordSuccess extends PatientAuthState {
  final String state;
  PatientForgotPasswordSuccess(this.state);
}

class PatientForgotPasswordError extends PatientAuthState {
  final String error;
  PatientForgotPasswordError(this.error);
}

class GetPatientLoading extends PatientAuthState {}

class GetPatientSuccess extends PatientAuthState {
  final PatientEntity patientEntity;
  GetPatientSuccess(this.patientEntity);
}

class GetPatientError extends PatientAuthState {
  final String error;
  GetPatientError(this.error);
}
