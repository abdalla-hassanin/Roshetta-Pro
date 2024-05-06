import 'dart:io';

import 'package:roshetta_pro/features/pharmacy_auth/data/data_sources/pharmacy_auth_data_source.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/repositories/pharmacy_auth_repository.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

class PharmacyAuthRepositoryImpl implements PharmacyAuthRepository {
  final PharmacyAuthDataSource _dataSource;

  PharmacyAuthRepositoryImpl(this._dataSource);

  @override
  Future<String> pharmacySignIn(String email, String password) async {
    return await _dataSource.pharmacySignIn(email, password);
  }

  @override
  Future<String> pharmacySignUp(PharmacySignUpParams params) async {
    return await _dataSource.pharmacySignUp(params);
  }

  @override
  Future<String> pharmacyUploadImageToStorage(File image) async {
    return await _dataSource.pharmacyUploadImageToStorage(image);
  }


  @override
  Future<String> pharmacySignOut() async {
    return await _dataSource.pharmacySignOut();
  }

  @override
  Future<String> pharmacyForgotPassword(String email) async {
    return await _dataSource.pharmacyForgotPassword(email);
  }

  @override
  Future<PharmacyEntity> getPharmacy() async {
    return await _dataSource.getPharmacy();
  }
}
