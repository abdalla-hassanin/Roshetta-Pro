import 'dart:io';

import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_sign_up_params.dart';

abstract class PatientAuthRepository {
  Future<String> patientSignIn(String email, String password);
  Future<String> patientSignUp(PatientSignUpParams params);
  Future<String> patientUploadImageToStorage(File image);
  Future<String> patientSignOut();
  Future<String>patientForgotPassword(String email);
  Future<PatientEntity> getPatient();

}
