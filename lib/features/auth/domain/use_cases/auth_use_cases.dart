import 'dart:io';

import 'package:roshetta_pro/features/auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<String> call(String email, String password) async {
    return await _repository.signIn(email, password);
  }
}

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<String> call() async {
    return await _repository.signOut();
  }
}

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<String> call(String email) async {
    return await _repository.forgotPassword(email);
  }
}

class UploadImageToStorageUseCase {
  final AuthRepository _repository;

  UploadImageToStorageUseCase(this._repository);

  Future<String> call(File image) async {
    return await _repository.uploadImageToStorage(image);
  }
}

class DoctorSignUpUseCase {
  final AuthRepository _repository;

  DoctorSignUpUseCase(this._repository);

  Future<String> call(DoctorSignUpParams params) async {
    return await _repository.doctorSignUp(params);
  }
}

class GetDoctorUseCase {
  final AuthRepository _repository;

  GetDoctorUseCase(this._repository);

  Future<DoctorEntity> call() async {
    return await _repository.getDoctor();
  }
}

class PatientSignUpUseCase {
  final AuthRepository _repository;

  PatientSignUpUseCase(this._repository);

  Future<String> call(PatientSignUpParams params) async {
    return await _repository.patientSignUp(params);
  }
}

class GetPatientUseCase {
  final AuthRepository _repository;

  GetPatientUseCase(this._repository);

  Future<PatientEntity> call() async {
    return await _repository.getPatient();
  }
}

class PharmacySignUpUseCase {
  final AuthRepository _repository;

  PharmacySignUpUseCase(this._repository);

  Future<String> call(PharmacySignUpParams params) async {
    return await _repository.pharmacySignUp(params);
  }
}

class GetPharmacyUseCase {
  final AuthRepository _repository;

  GetPharmacyUseCase(this._repository);

  Future<PharmacyEntity> call() async {
    return await _repository.getPharmacy();
  }
}
