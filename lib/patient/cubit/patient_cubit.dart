import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/patient/cubit/patient_state.dart';
import 'package:roshetta_pro/core/models/medical_history_model.dart';
import 'package:roshetta_pro/core/models/patient_model.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/core/models/x_rays_analysis_model.dart';

class PatientCubit extends Cubit<PatientState> {
  PatientCubit() : super(PatientInitial());

  static PatientCubit get(context) => BlocProvider.of(context);


  Future getPatientData({required String uId}) async {
    await getPatientModel(uId:uId);
    await getMedicalHistoryModel(uId:uId);
    await getXRaysAnalysisModel(uId:uId);
    await getPrescriptionModel(uId:uId);
  }

  PatientModel? patientModel;

  Future getPatientModel({required String uId}) async {
    emit(PatientModelLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      patientModel = PatientModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(patientModel!.toJson());
      }
      emit(PatientModelSuccessState());
    }).catchError((error) {
      emit(PatientModelErrorState());
    });
  }

  List<MedicalHistoryModel?> medicalHistoryModels = [];

  Future getMedicalHistoryModel({required String uId}) async {
    emit(MedicalHistoryModelLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('medicalHistoryModel')
        .get()
        .then((value) {
      for (var element in value.docs) {
        medicalHistoryModels.add(MedicalHistoryModel.fromJson(element.data()));
      }
      emit(MedicalHistoryModelSuccessState());
    }).catchError((error) {
      emit(MedicalHistoryModelErrorState());
    });
  }

  List<XRaysAnalysisModel?> xRaysAnalysisModels = [];

  Future getXRaysAnalysisModel({required String uId}) async {
    emit(XRaysAnalysisModelLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('xRaysAnalysisModel')
        .get()
        .then((value) {
      for (var element in value.docs) {
        xRaysAnalysisModels.add(XRaysAnalysisModel.fromJson(element.data()));
      }
      emit(XRaysAnalysisModelSuccessState());
    }).catchError((error) {
      emit(XRaysAnalysisModelErrorState());
    });
  }

  List<PrescriptionModel?> prescriptionModels = [];

  Future getPrescriptionModel({required String uId}) async {
    emit(PrescriptionModelLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('prescriptionModel')
        .get()
        .then((value) {
      for (var element in value.docs) {
        prescriptionModels.add(PrescriptionModel.fromJson(element.data()));
      }
      emit(PrescriptionModelSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(PrescriptionModelErrorState());
    });
  }


  Future getDoctorModel({required String uId}) async {
    DoctorModel? doctorModel;

    emit(DoctorIDModelLoadingState());
  await  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
    if (kDebugMode) {
      print('==============');
    }
      doctorModel = DoctorModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(doctorModel!.toJson());
      }
      emit(DoctorIDModelSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(DoctorIDModelErrorState());
    });
    return doctorModel;
  }}
