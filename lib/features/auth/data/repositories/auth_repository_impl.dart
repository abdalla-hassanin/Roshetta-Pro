import 'dart:io';

import 'package:roshetta_pro/features/auth/data/data_sources/auth_data_source.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<String> signIn(String email, String password) async {
    return await _dataSource.signIn(email, password);
  }

  @override
  Future<String> signOut() async {
    return await _dataSource.signOut();
  }

  @override
  Future<String> uploadImageToStorage(File image) async {
    return await _dataSource.uploadImageToStorage(image);
  }

  @override
  Future<String> forgotPassword(String email) async {
    return await _dataSource.forgotPassword(email);
  }

  @override
  Future<String> doctorSignUp(DoctorSignUpParams params) async {
    return await _dataSource.doctorSignUp(params);
  }

  @override
  Future<DoctorEntity> getDoctor() async {
    return await _dataSource.getDoctor();
  }

  @override
  Future<String> patientSignUp(PatientSignUpParams params) async {
    return await _dataSource.patientSignUp(params);
  }

  @override
  Future<PatientEntity> getPatient() async {
    return await _dataSource.getPatient();
  }

  @override
  Future<String> pharmacySignUp(PharmacySignUpParams params) async {
    return await _dataSource.pharmacySignUp(params);
  }

  @override
  Future<PharmacyEntity> getPharmacy() async {
    return await _dataSource.getPharmacy();
  }
}
