import 'dart:io';

import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

abstract class AuthRepository {
  Future<String> signIn(String email, String password);

  Future<String> signOut();

  Future<String> forgotPassword(String email);

  Future<String> uploadImageToStorage(File image);

  Future<String> doctorSignUp(DoctorSignUpParams params);

  Future<DoctorEntity> getDoctor();

  Future<String> patientSignUp(PatientSignUpParams params);

  Future<PatientEntity> getPatient();

  Future<String> pharmacySignUp(PharmacySignUpParams params);

  Future<PharmacyEntity> getPharmacy();
}
