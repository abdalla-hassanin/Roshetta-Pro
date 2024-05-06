import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/use_cases/pharmacy_auth_use_cases.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

part 'pharmacy_auth_state.dart';

class PharmacyAuthCubit extends Cubit<PharmacyAuthState> {
  PharmacyAuthCubit() : super(PharmacyAuthInitial());

  Future<void> pharmacySignIn(String email, String password) async {
    try {
      emit(PharmacySignInLoading());
      final result = await getIt<PharmacySignInUseCase>().call(email, password);
      emit(PharmacySignInSuccess(result));
    } catch (e) {
      emit(PharmacySignInError(e.toString()));
    }
  }

  Future<void> pharmacySignUp(PharmacySignUpParams params) async {
    try {
      emit(PharmacySignUpLoading());
      final result = await getIt<PharmacySignUpUseCase>().call(params);
      emit(PharmacySignUpSuccess(result));
    } catch (e) {
      emit(PharmacySignUpError(e.toString()));
    }
  }
  Future<void> pharmacyUploadImageToStorage(File image) async {
    try {
      emit(PharmacyUploadImageToStorageLoading());
      final imageUrl = await getIt<PharmacyUploadImageToStorageUseCase>().call(image);
      emit(PharmacyUploadImageToStorageSuccess(imageUrl));
    } catch (e) {
      emit(PharmacyUploadImageToStorageError(e.toString()));
    }
  }

  Future<void> pharmacySignOut() async {
    try {
      emit(PharmacySignOutLoading());
      final result = await getIt<PharmacySignOutUseCase>().call();
      emit(PharmacySignOutSuccess(result));
    } catch (e) {
      emit(PharmacySignOutError(e.toString()));
    }
  }

  Future<void> pharmacyForgotPassword(String email) async {
    try {
      emit(PharmacyForgotPasswordLoading());
      final result = await getIt<PharmacyForgotPasswordUseCase>().call(email);
      emit(PharmacyForgotPasswordSuccess(result));
    } catch (e) {
      emit(PharmacyForgotPasswordError(e.toString()));
    }
  }

  Future<void> getPharmacy() async {
    try {
      emit(GetPharmacyLoading());
      final result = await getIt<GetPharmacyUseCase>().call();
      emit(GetPharmacySuccess(result));
    } catch (e) {
      emit(GetPharmacyError(e.toString()));
    }
  }

}
