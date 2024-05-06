import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/dependency_injection.dart';
import 'package:roshetta_pro/features/doctor/domain/use_cases/doctor_use_cases.dart';
import 'package:roshetta_pro/features/patient/data/models/drug_model.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/patient/domain/entities/drug_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/medical_history_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/domain/entities/x_ray_entity.dart';
import 'package:roshetta_pro/features/patient/domain/use_cases/patient_use_cases.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  List<DrugModel> drugs = [];

  void addDrugEntityToList(DrugModel drug)  {
    drugs.add(drug);
    emit(AddDrugToListSuccess(drugs));
  }

  Future<void> getPatientByMobileNumber(String mobileNumber) async {
    try {
      emit(GetPatientByMobileNumberLoading());
      final result =
          await getIt<GetPatientByMobileNumberUseCase>().call(mobileNumber);
      emit(GetPatientByMobileNumberSuccess(result));
    } catch (e) {
      emit(GetPatientByMobileNumberError(e.toString()));
    }
  }

  Future<void> getPatientPrescriptions(String patientId) async {
    try {
      emit(GetPatientPrescriptionsLoading());
      final result =
          await getIt<GetPatientPrescriptionsUseCase>().call(patientId);
      emit(GetPatientPrescriptionsSuccess(result));
    } catch (e) {
      emit(GetPatientPrescriptionsError(e.toString()));
    }
  }

  Future<void> getPatientXRays(String patientId) async {
    try {
      emit(GetPatientXRaysLoading());
      final result = await getIt<GetPatientXRaysUseCase>().call(patientId);
      emit(GetPatientXRaysSuccess(result));
    } catch (e) {
      emit(GetPatientXRaysError(e.toString()));
    }
  }

  Future<void> getPatientMedicalHistory(String patientId) async {
    try {
      emit(GetPatientMedicalHistoryLoading());
      final result =
          await getIt<GetPatientMedicalHistoryUseCase>().call(patientId);
      emit(GetPatientMedicalHistorySuccess(result));
    } catch (e) {
      emit(GetPatientMedicalHistoryError(e.toString()));
    }
  }

  Future<void> addNewPrescription(
      String patientId, PrescriptionModel prescription) async {
    try {
      emit(AddNewPrescriptionLoading());
      final result = await getIt<AddNewPrescriptionUseCase>()
          .call(patientId, prescription);
      emit(AddNewPrescriptionSuccess(result));
    } catch (e) {
      emit(AddNewPrescriptionError(e.toString()));
    }
  }

  Future<void> addNewXRay(String patientId, XRayModel xRay) async {
    try {
      emit(AddNewXRayLoading());
      final result = await getIt<AddNewXRayUseCase>().call(patientId, xRay);
      emit(AddNewXRaySuccess(result));
    } catch (e) {
      emit(AddNewXRayError(e.toString()));
    }
  }

  Future<void> addNewMedicalHistory(
      String patientId, MedicalHistoryModel medicalHistory) async {
    try {
      emit(AddNewMedicalHistoryLoading());
      final result = await getIt<AddNewMedicalHistoryUseCase>()
          .call(patientId, medicalHistory);
      emit(AddNewMedicalHistorySuccess(result));
    } catch (e) {
      emit(AddNewMedicalHistoryError(e.toString()));
    }
  }

  Future<void> xRayUploadImageToStorage(File image, String patientId) async {
    try {
      emit(XRayUploadImageToStorageLoading());
      final result =
          await getIt<XRayUploadImageToStorageUseCase>().call(image, patientId);
      emit(XRayUploadImageToStorageSuccess(result));
    } catch (e) {
      emit(XRayUploadImageToStorageError(e.toString()));
    }
  }
}
