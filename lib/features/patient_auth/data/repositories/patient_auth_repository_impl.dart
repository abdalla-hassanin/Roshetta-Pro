import 'dart:io';

import 'package:roshetta_pro/features/patient_auth/data/data_sources/patient_auth_data_source.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/patient_auth/domain/repositories/patient_auth_repository.dart';

class PatientAuthRepositoryImpl implements PatientAuthRepository {
  final PatientAuthDataSource _dataSource;

  PatientAuthRepositoryImpl(this._dataSource);

  @override
  Future<String> patientSignIn(String email, String password) async {
    return await _dataSource.patientSignIn(email, password);
  }

  @override
  Future<String> patientSignUp(PatientSignUpParams params) async {
    return await _dataSource.patientSignUp(params);
  }

  @override
  Future<String> patientUploadImageToStorage(File image) async {
    return await _dataSource.patientUploadImageToStorage(image);
  }


  @override
  Future<String> patientSignOut() async {
    return await _dataSource.patientSignOut();
  }

  @override
  Future<String> patientForgotPassword(String email) async {
    return await _dataSource.patientForgotPassword(email);
  }

  @override
  Future<PatientEntity> getPatient() async {
    return await _dataSource.getPatient();
  }
}
