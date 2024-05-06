import 'dart:io';

import 'package:roshetta_pro/features/doctor_auth/data/data_sources/doctor_auth_data_source.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/repositories/doctor_auth_repository.dart';

class DoctorAuthRepositoryImpl implements DoctorAuthRepository {
  final DoctorAuthDataSource _dataSource;

  DoctorAuthRepositoryImpl(this._dataSource);

  @override
  Future<String> doctorSignIn(String email, String password) async {
    return await _dataSource.doctorSignIn(email, password);
  }

  @override
  Future<String> doctorSignUp(DoctorSignUpParams params) async {
    return await _dataSource.doctorSignUp(params);
  }

  @override
  Future<String> doctorUploadImageToStorage(File image) async {
    return await _dataSource.doctorUploadImageToStorage(image);
  }


  @override
  Future<String> doctorSignOut() async {
    return await _dataSource.doctorSignOut();
  }

  @override
  Future<String> doctorForgotPassword(String email) async {
    return await _dataSource.doctorForgotPassword(email);
  }

  @override
  Future<DoctorEntity> getDoctor() async {
    return await _dataSource.getDoctor();
  }
}
