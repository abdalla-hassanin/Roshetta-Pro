import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/use_cases/doctor_auth_use_cases.dart';

part 'doctor_auth_state.dart';

class DoctorAuthCubit extends Cubit<DoctorAuthState> {
  DoctorAuthCubit() : super(DoctorAuthInitial());


  Map<String, dynamic> specializationValue = {};

  doctorChangeSpecializationValue(value) {
    specializationValue = value;
    emit(DoctorChangeSpecializationValueState());
  }


  Future<void> doctorSignIn(String email, String password) async {
    try {
      emit(DoctorSignInLoading());
      final result = await getIt<DoctorSignInUseCase>().call(email, password);
      emit(DoctorSignInSuccess(result));
    } catch (e) {
      emit(DoctorSignInError(e.toString()));
    }
  }

  Future<void> doctorSignUp(DoctorSignUpParams params) async {
    try {
      emit(DoctorSignUpLoading());
      final result = await getIt<DoctorSignUpUseCase>().call(params);
      emit(DoctorSignUpSuccess(result));
    } catch (e) {
      emit(DoctorSignUpError(e.toString()));
    }
  }
  Future<void> doctorUploadImageToStorage(File image) async {
    try {
      emit(DoctorUploadImageToStorageLoading());
      final imageUrl = await getIt<DoctorUploadImageToStorageUseCase>().call(image);
      emit(DoctorUploadImageToStorageSuccess(imageUrl));
    } catch (e) {
      emit(DoctorUploadImageToStorageError(e.toString()));
    }
  }

  Future<void> doctorSignOut() async {
    try {
      emit(DoctorSignOutLoading());
      final result = await getIt<DoctorSignOutUseCase>().call();
      emit(DoctorSignOutSuccess(result));
    } catch (e) {
      emit(DoctorSignOutError(e.toString()));
    }
  }

  Future<void> doctorForgotPassword(String email) async {
    try {
      emit(DoctorForgotPasswordLoading());
      final result = await getIt<DoctorForgotPasswordUseCase>().call(email);
      emit(DoctorForgotPasswordSuccess(result));
    } catch (e) {
      emit(DoctorForgotPasswordError(e.toString()));
    }
  }

  Future<void> getDoctor() async {
    try {
      emit(GetDoctorLoading());
      final result = await getIt<GetDoctorUseCase>().call();
      emit(GetDoctorSuccess(result));
    } catch (e) {
      emit(GetDoctorError(e.toString()));
    }
  }

}
