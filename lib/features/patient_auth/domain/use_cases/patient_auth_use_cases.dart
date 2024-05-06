import 'dart:io';

import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/patient_auth/domain/repositories/patient_auth_repository.dart';

class PatientSignInUseCase {
  final PatientAuthRepository _repository;

  PatientSignInUseCase(this._repository);

  Future<String> call(String email, String password) async {
    return await _repository.patientSignIn(email, password);
  }
}

class PatientSignUpUseCase {
  final PatientAuthRepository _repository;

  PatientSignUpUseCase(this._repository);

  Future<String> call(PatientSignUpParams params) async {
    return await _repository.patientSignUp(params);
  }
}

class PatientUploadImageToStorageUseCase {
  final PatientAuthRepository _repository;

  PatientUploadImageToStorageUseCase(this._repository);

  Future<String> call(File image) async {
    return await _repository.patientUploadImageToStorage(image);
  }
}

class PatientSignOutUseCase {
  final PatientAuthRepository _repository;

  PatientSignOutUseCase(this._repository);

  Future<String> call() async {
    return await _repository.patientSignOut();
  }
}

class PatientForgotPasswordUseCase {
  final PatientAuthRepository _repository;

  PatientForgotPasswordUseCase(this._repository);

  Future<String> call(String email) async {
    return await _repository.patientForgotPassword(email);
  }
}

class GetPatientUseCase {
  final PatientAuthRepository _repository;

  GetPatientUseCase(this._repository);

  Future<PatientEntity> call() async {
    return await _repository.getPatient();
  }
}
