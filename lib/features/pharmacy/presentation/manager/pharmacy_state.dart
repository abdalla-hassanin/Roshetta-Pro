part of 'pharmacy_cubit.dart';

abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class GetPharmacyLoading extends PharmacyState {}

class GetPharmacySuccess extends PharmacyState {
  final PharmacyEntity pharmacy;
  GetPharmacySuccess(this.pharmacy);
}

class GetPharmacyError extends PharmacyState {
  final String error;
  GetPharmacyError(this.error);
}

class GetPrescriptionByUserPhoneAndPrescriptionIdLoading
    extends PharmacyState {}

class GetPrescriptionByUserPhoneAndPrescriptionIdSuccess
    extends PharmacyState {
  final PrescriptionEntity prescription;
  GetPrescriptionByUserPhoneAndPrescriptionIdSuccess(this.prescription);
}

class GetPrescriptionByUserPhoneAndPrescriptionIdError extends PharmacyState {
  final String error;
  GetPrescriptionByUserPhoneAndPrescriptionIdError(this.error);
}

