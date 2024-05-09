
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/entities/pharmacy_sign_up_params.dart';
import 'package:roshetta_pro/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(SignInLoading());
      final result = await getIt<SignInUseCase>().call(email, password);
      emit(SignInSuccess(result));
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(SignOutLoading());
      final result = await getIt<SignOutUseCase>().call();
      emit(SignOutSuccess(result));
    } catch (e) {
      emit(SignOutError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      emit(ForgotPasswordLoading());
      final result = await getIt<ForgotPasswordUseCase>().call(email);
      emit(ForgotPasswordSuccess(result));
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }

  File? pickedImage;
  void emptyPickedImage()  {
    pickedImage = null;
    emit(EmptyPickedImage());
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // If image is picked, update the state
      this.pickedImage = File(pickedImage.path);
      emit(PickImageSuccess());
    } else {
      emit(PickImageError('No image selected.'));
    }
  }



  Future<void> uploadImageToStorage(File image) async {
    try {
      emit(UploadImageToStorageLoading());
      final result = await getIt<UploadImageToStorageUseCase>().call(image);
      pickedImage = null;
      emit(UploadImageToStorageSuccess(result));
    } catch (e) {
      emit(UploadImageToStorageError(e.toString()));
    }
  }


  Map<String, dynamic> specializationValue = {};

  doctorChangeSpecializationValue(value) {
    specializationValue = value;
    emit(DoctorChangeSpecializationValueState());
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

  Future<void> getDoctor() async {
    try {
      emit(GetDoctorLoading());
      final result = await getIt<GetDoctorUseCase>().call();
      emit(GetDoctorSuccess(result));
    } catch (e) {
      emit(GetDoctorError(e.toString()));
    }
  }

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


  Future<void> patientSignUp(PatientSignUpParams params) async {
    try {
      emit(PatientSignUpLoading());
      final result = await getIt<PatientSignUpUseCase>().call(params);
      emit(PatientSignUpSuccess(result));
    } catch (e) {
      emit(PatientSignUpError(e.toString()));
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

  Future<void> pharmacySignUp(PharmacySignUpParams params) async {
    try {
      emit(PharmacySignUpLoading());
      final result = await getIt<PharmacySignUpUseCase>().call(params);
      emit(PharmacySignUpSuccess(result));
    } catch (e) {
      emit(PharmacySignUpError(e.toString()));
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