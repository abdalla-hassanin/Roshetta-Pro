part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class ChangeSuffixIconState extends AuthState {}
class ChangeSpecializationValueState extends AuthState {}
class ChangeGenderValueState extends AuthState {}
class ChangeBloodValueState extends AuthState {}
class ChangeHeightValueState extends AuthState {}
class ChangeWeightValueState extends AuthState {}

///ResetPassword State
class ResetPasswordLoadingState extends AuthState{}
class ResetPasswordSuccessState extends AuthState{}
class ResetPasswordErrorState extends AuthState{}


///Login State
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends AuthState{
  final  String error;
  LoginErrorState(this.error);
}


///SignUp Doctor
class SignUpDoctorLoadingState extends AuthState{}
class SignUpDoctorSuccessState extends AuthState{
  final  String uId;
  SignUpDoctorSuccessState(this.uId);
}
class SignUpDoctorErrorState extends AuthState{
  final  String error;
  SignUpDoctorErrorState(this.error);
}


///SignUp Patient
class SignUpPatientLoadingState extends AuthState{}
class SignUpPatientSuccessState extends AuthState{
  final  String uId;
  SignUpPatientSuccessState(this.uId);
}
class SignUpPatientErrorState extends AuthState{
  final  String error;
  SignUpPatientErrorState(this.error);
}


///SignUp pharmacy
class SignUpPharmacyLoadingState extends AuthState{}
class SignUpPharmacySuccessState extends AuthState{
  final  String uId;
  SignUpPharmacySuccessState(this.uId);
}
class SignUpPharmacyErrorState extends AuthState{
  final  String error;
  SignUpPharmacyErrorState(this.error);
}



///Create Doctor
class CreateDoctorLoadingState extends AuthState{}
class CreateDoctorSuccessState extends AuthState{
  final  String uId;
  CreateDoctorSuccessState(this.uId);
}
class CreateDoctorErrorState extends AuthState{}


///Create Patient
class CreatePatientLoadingState extends AuthState{}
class CreatePatientSuccessState extends AuthState{
  final  String uId;
  CreatePatientSuccessState(this.uId);
}
class CreatePatientErrorState extends AuthState{}


///Create pharmacy
class CreatePharmacyLoadingState extends AuthState{}
class CreatePharmacySuccessState extends AuthState{
  final  String uId;
  CreatePharmacySuccessState(this.uId);
}
class CreatePharmacyErrorState extends AuthState{}




///User State
class UserLoadingState extends AuthState{}
class UserSuccessState extends AuthState {}
class UserErrorState extends AuthState{}
///End of User State

