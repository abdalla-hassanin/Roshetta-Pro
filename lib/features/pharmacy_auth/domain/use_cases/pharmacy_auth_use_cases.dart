import 'dart:io';

import 'package:roshetta_pro/features/pharmacy_auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/repositories/pharmacy_auth_repository.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

class PharmacySignInUseCase {
  final PharmacyAuthRepository _repository;

  PharmacySignInUseCase(this._repository);

  Future<String> call(String email, String password) async {
    return await _repository.pharmacySignIn(email, password);
  }
}

class PharmacySignUpUseCase {
  final PharmacyAuthRepository _repository;

  PharmacySignUpUseCase(this._repository);

  Future<String> call(PharmacySignUpParams params) async {
    return await _repository.pharmacySignUp(params);
  }
}

class PharmacyUploadImageToStorageUseCase {
  final PharmacyAuthRepository _repository;

  PharmacyUploadImageToStorageUseCase(this._repository);

  Future<String> call(File image) async {
    return await _repository.pharmacyUploadImageToStorage(image);
  }
}

class PharmacySignOutUseCase {
  final PharmacyAuthRepository _repository;

  PharmacySignOutUseCase(this._repository);

  Future<String> call() async {
    return await _repository.pharmacySignOut();
  }
}

class PharmacyForgotPasswordUseCase {
  final PharmacyAuthRepository _repository;

  PharmacyForgotPasswordUseCase(this._repository);

  Future<String> call(String email) async {
    return await _repository.pharmacyForgotPassword(email);
  }
}

class GetPharmacyUseCase {
  final PharmacyAuthRepository _repository;

  GetPharmacyUseCase(this._repository);

  Future<PharmacyEntity> call() async {
    return await _repository.getPharmacy();
  }
}
