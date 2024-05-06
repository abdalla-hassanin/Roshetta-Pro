import 'dart:io';

import 'package:roshetta_pro/features/pharmacy_auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

abstract class PharmacyAuthRepository {
  Future<String> pharmacySignIn(String email, String password);
  Future<String> pharmacySignUp(PharmacySignUpParams params);
  Future<String> pharmacyUploadImageToStorage(File image);
  Future<String> pharmacySignOut();
  Future<String>pharmacyForgotPassword(String email);
  Future<PharmacyEntity> getPharmacy();

}
