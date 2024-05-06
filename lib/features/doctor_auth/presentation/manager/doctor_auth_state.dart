part of 'doctor_auth_cubit.dart';

abstract class DoctorAuthState {}

 class DoctorAuthInitial extends DoctorAuthState {}

 class DoctorChangeSpecializationValueState extends DoctorAuthState {}

class DoctorSignInLoading extends DoctorAuthState {}

class DoctorSignInSuccess extends DoctorAuthState {
  final String uId;
  DoctorSignInSuccess(this.uId);
}

class DoctorSignInError extends DoctorAuthState {
  final String error;
  DoctorSignInError(this.error);
}

class DoctorSignUpLoading extends DoctorAuthState {}

class DoctorSignUpSuccess extends DoctorAuthState {
  final String state;
  DoctorSignUpSuccess(this.state);
}

class DoctorSignUpError extends DoctorAuthState {
  final String error;
  DoctorSignUpError(this.error);
}

class DoctorUploadImageToStorageLoading extends DoctorAuthState {}

class DoctorUploadImageToStorageSuccess extends DoctorAuthState {
  final String imageUrl;
  DoctorUploadImageToStorageSuccess(this.imageUrl);
}

class DoctorUploadImageToStorageError extends DoctorAuthState {
  final String error;
  DoctorUploadImageToStorageError(this.error);
}

class DoctorSignOutLoading extends DoctorAuthState {}

class DoctorSignOutSuccess extends DoctorAuthState {
  final String state;
  DoctorSignOutSuccess(this.state);
}

class DoctorSignOutError extends DoctorAuthState {
  final String error;
  DoctorSignOutError(this.error);
}

class DoctorForgotPasswordLoading extends DoctorAuthState {}

class DoctorForgotPasswordSuccess extends DoctorAuthState {
  final String state;
  DoctorForgotPasswordSuccess(this.state);
}

class DoctorForgotPasswordError extends DoctorAuthState {
  final String error;
  DoctorForgotPasswordError(this.error);
}

class GetDoctorLoading extends DoctorAuthState {}

class GetDoctorSuccess extends DoctorAuthState {
  final DoctorEntity doctorEntity;
  GetDoctorSuccess(this.doctorEntity);
}

class GetDoctorError extends DoctorAuthState {
  final String error;
  GetDoctorError(this.error);
}
