import 'dart:io';

import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_sign_up_params.dart';

abstract class DoctorAuthRepository {
  Future<String> doctorSignIn(String email, String password);
  Future<String> doctorSignUp(DoctorSignUpParams params);
  Future<String> doctorUploadImageToStorage(File image);
  Future<String> doctorSignOut();
  Future<String>doctorForgotPassword(String email);
  Future<DoctorEntity> getDoctor();

}
