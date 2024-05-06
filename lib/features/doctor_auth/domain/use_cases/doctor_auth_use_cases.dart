import 'dart:io';

import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/repositories/doctor_auth_repository.dart';

class DoctorSignInUseCase {
  final DoctorAuthRepository _repository;

  DoctorSignInUseCase(this._repository);

  Future<String> call(String email, String password) async {
    return await _repository.doctorSignIn(email, password);
  }
}

class DoctorSignUpUseCase {
  final DoctorAuthRepository _repository;

  DoctorSignUpUseCase(this._repository);

  Future<String> call(DoctorSignUpParams params) async {
    return await _repository.doctorSignUp(params);
  }
}

class DoctorUploadImageToStorageUseCase {
  final DoctorAuthRepository _repository;

  DoctorUploadImageToStorageUseCase(this._repository);

  Future<String> call(File image) async {
    return await _repository.doctorUploadImageToStorage(image);
  }
}

class DoctorSignOutUseCase {
  final DoctorAuthRepository _repository;

  DoctorSignOutUseCase(this._repository);

  Future<String> call() async {
    return await _repository.doctorSignOut();
  }
}

class DoctorForgotPasswordUseCase {
  final DoctorAuthRepository _repository;

  DoctorForgotPasswordUseCase(this._repository);

  Future<String> call(String email) async {
    return await _repository.doctorForgotPassword(email);
  }
}

class GetDoctorUseCase {
  final DoctorAuthRepository _repository;

  GetDoctorUseCase(this._repository);

  Future<DoctorEntity> call() async {
    return await _repository.getDoctor();
  }
}
