part of 'pharmacy_auth_cubit.dart';

abstract class PharmacyAuthState {}

 class PharmacyAuthInitial extends PharmacyAuthState {}

class PharmacySignInLoading extends PharmacyAuthState {}

class PharmacySignInSuccess extends PharmacyAuthState {
  final String uId;
  PharmacySignInSuccess(this.uId);
}

class PharmacySignInError extends PharmacyAuthState {
  final String error;
  PharmacySignInError(this.error);
}

class PharmacySignUpLoading extends PharmacyAuthState {}

class PharmacySignUpSuccess extends PharmacyAuthState {
  final String state;
  PharmacySignUpSuccess(this.state);
}

class PharmacySignUpError extends PharmacyAuthState {
  final String error;
  PharmacySignUpError(this.error);
}

class PharmacyUploadImageToStorageLoading extends PharmacyAuthState {}

class PharmacyUploadImageToStorageSuccess extends PharmacyAuthState {
  final String imageUrl;
  PharmacyUploadImageToStorageSuccess(this.imageUrl);
}

class PharmacyUploadImageToStorageError extends PharmacyAuthState {
  final String error;
  PharmacyUploadImageToStorageError(this.error);
}

class PharmacySignOutLoading extends PharmacyAuthState {}

class PharmacySignOutSuccess extends PharmacyAuthState {
  final String state;
  PharmacySignOutSuccess(this.state);
}

class PharmacySignOutError extends PharmacyAuthState {
  final String error;
  PharmacySignOutError(this.error);
}

class PharmacyForgotPasswordLoading extends PharmacyAuthState {}

class PharmacyForgotPasswordSuccess extends PharmacyAuthState {
  final String state;
  PharmacyForgotPasswordSuccess(this.state);
}

class PharmacyForgotPasswordError extends PharmacyAuthState {
  final String error;
  PharmacyForgotPasswordError(this.error);
}

class GetPharmacyLoading extends PharmacyAuthState {}

class GetPharmacySuccess extends PharmacyAuthState {
  final PharmacyEntity pharmacyEntity;
  GetPharmacySuccess(this.pharmacyEntity);
}

class GetPharmacyError extends PharmacyAuthState {
  final String error;
  GetPharmacyError(this.error);
}
