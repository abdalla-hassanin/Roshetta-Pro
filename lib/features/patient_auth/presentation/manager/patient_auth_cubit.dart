import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/patient_auth/domain/use_cases/patient_auth_use_cases.dart';

part 'patient_auth_state.dart';

class PatientAuthCubit extends Cubit<PatientAuthState> {
  PatientAuthCubit() : super(PatientAuthInitial());

  String patientBloodValue = '';

  patientChangeBloodValue(value) {
    patientBloodValue = value;
    emit(PatientChangeBloodValue());
  }
  String patientGenderValue = '';

  patientChangeGenderValue(value) {
    patientGenderValue = value;
    emit(PatientChangeGenderValue());
  }

  int patientHeightValue = 100;

  patientChangeHeightValue(value) {
    patientHeightValue = value;
    emit(PatientChangeHeightValue());
  }

  int patientWeightValue = 50;

  patientChangeWeightValue(value) {
    patientWeightValue = value;
    emit(PatientChangeWeightValue());
  }

  Future<void> patientSignIn(String email, String password) async {
    try {
      emit(PatientSignInLoading());
      final result = await getIt<PatientSignInUseCase>().call(email, password);
      emit(PatientSignInSuccess(result));
    } catch (e) {
      emit(PatientSignInError(e.toString()));
    }
  }

  Future<void> patientSignUp(PatientSignUpParams params) async {
    try {
      emit(PatientSignUpLoading());
      final result = await getIt<PatientSignUpUseCase>().call(params);
      emit(PatientSignUpSuccess(result));
    } catch (e) {
      emit(PatientSignUpError(e.toString()));
    }
  }

  Future<void> patientUploadImageToStorage(File image) async {
    try {
      emit(PatientUploadImageToStorageLoading());
      final imageUrl =
          await getIt<PatientUploadImageToStorageUseCase>().call(image);
      emit(PatientUploadImageToStorageSuccess(imageUrl));
    } catch (e) {
      emit(PatientUploadImageToStorageError(e.toString()));
    }
  }

  Future<void> patientSignOut() async {
    try {
      emit(PatientSignOutLoading());
      final result = await getIt<PatientSignOutUseCase>().call();
      emit(PatientSignOutSuccess(result));
    } catch (e) {
      emit(PatientSignOutError(e.toString()));
    }
  }

  Future<void> patientForgotPassword(String email) async {
    try {
      emit(PatientForgotPasswordLoading());
      final result = await getIt<PatientForgotPasswordUseCase>().call(email);
      emit(PatientForgotPasswordSuccess(result));
    } catch (e) {
      emit(PatientForgotPasswordError(e.toString()));
    }
  }

  Future<void> getPatient() async {
    try {
      emit(GetPatientLoading());
      final result = await getIt<GetPatientUseCase>().call();
      emit(GetPatientSuccess(result));
    } catch (e) {
      emit(GetPatientError(e.toString()));
    }
  }
}
