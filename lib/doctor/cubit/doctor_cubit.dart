import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/core/models/drug_model.dart';
import 'package:roshetta_pro/core/models/medical_history_model.dart';
import 'package:roshetta_pro/core/models/patient_model.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/core/models/x_rays_analysis_model.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  static DoctorCubit get(context) => BlocProvider.of(context);

  DoctorModel? doctorModel;

  Future getDoctorModel({required String uId}) async {
    emit(DoctorModelLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      doctorModel = DoctorModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(doctorModel!.toJson());
      }
      emit(DoctorModelSuccessState());
    }).catchError((error) {
      emit(DoctorModelErrorState());
    });
  }

  Future getPatientDoctorModel({required String uId}) async {
    DoctorModel? doctorModel;

    emit(PatientDoctorIDModelLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      print('==============');
      doctorModel = DoctorModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(doctorModel!.toJson());
      }
      emit(PatientDoctorIDModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PatientDoctorIDModelErrorState());
    });
    return doctorModel;
  }

  Future getPatientData({required String uId}) async {
    await getMedicalHistoryModel(uId: uId);
    await getXRaysAnalysisModel(uId: uId);
    await getPrescriptionModel(uId: uId);
  }

  PatientModel? patientModel;

  Future getPatientModel({required String mobilePhone}) async {
    emit(PatientModelLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .where('mobilePhone', isEqualTo: mobilePhone)
        .get()
        .then((value) {
      patientModel = PatientModel.fromJson(value.docs[0].data());
      getPatientData(uId: patientModel!.uId).then((value) {
        if (kDebugMode) {
          print(patientModel!.toJson());
        }
        emit(PatientModelSuccessState());
      });
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
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
          medicalHistoryModels.clear();
      for (var element in value.docs) {
        medicalHistoryModels.add(MedicalHistoryModel.fromJson(element.data()));
      }
      emit(MedicalHistoryModelSuccessState());
    }).catchError((error) {
      print(error.toString());
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
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
          xRaysAnalysisModels.clear();
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
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) {
          prescriptionModels.clear();
      for (var element in value.docs) {
        prescriptionModels.add(PrescriptionModel.fromJson(element.data()));
      }
      emit(PrescriptionModelSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PrescriptionModelErrorState());
    });
  }

  void createNewMedicalHistory({required String doctorId,
    required String doctorName,
    required String doctorImg,
    required String date,
    required String body}) {
    emit(NewMedicalHistoryLoadingState());

    MedicalHistoryModel medicalHistoryModel = MedicalHistoryModel(
        doctorId: doctorId,
        date: date,
        body: body,
        doctorName: doctorName,
        doctorImg: doctorImg, dateTime: FieldValue.serverTimestamp());
    FirebaseFirestore.instance
        .collection('users')
        .doc(patientModel!.uId)
        .collection('medicalHistoryModel')
        .add(medicalHistoryModel.toJson())
        .then((value) {
      emit(NewMedicalHistorySuccessState());
    }).catchError((error) {
      emit(NewMedicalHistoryErrorState());
    });
  }

  void createNewXRaysAnalysis({required String doctorId,
    required String doctorName,
    required String doctorImg,
    required String labName,
    required String xRayTitle,
    required String date,
    required String notes}) {
    emit(NewXRaysAnalysisLoadingState());
    FirebaseStorage.instance
        .ref()
        .child(Uri
        .file(postImage!.path)
        .pathSegments
        .last)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        XRaysAnalysisModel xRaysAnalysisModel = XRaysAnalysisModel(
            doctorId: doctorId,
            doctorName: doctorName,
            doctorImg: doctorImg,
            labName: labName,
            date: date,
            xRayImg: value,
            notes: notes,
            xRayTitle: xRayTitle
            , dateTime: FieldValue.serverTimestamp());
        FirebaseFirestore.instance
            .collection('users')
            .doc(patientModel!.uId)
            .collection('xRaysAnalysisModel')
            .add(xRaysAnalysisModel.toJson())
            .then((value) {
          emit(NewXRaysAnalysisSuccessState());
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(NewXRaysAnalysisErrorState());
    });
  }

  File? postImage;
  ImagePicker? picker = ImagePicker();

  void popPostImage() {
    postImage = null;
    emit(DeleteXRaysPicState());
  }

  Future getPostImage() async {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetXRaysPicSuccessState());
    } else {
      print('No Image Selected');
      emit(GetXRaysPicErrorState());
    }
  }

  List<DrugModel> drugModels = [];

  addDrugModel({
    required String drugName,
    required String drugQty,
    required String drugType,
    required String durationOfUse,
    required String timeOfUse,
    required String note
  }) {
    drugModels.add(DrugModel(
        drugName: drugName,
        drugQty: drugQty,
        drugType: drugType,
        durationOfUse: durationOfUse,
        timeOfUse: timeOfUse,
        note: note));
    emit(AddDrugModelState());
  }

  void createNewPrescription({
    required String doctorId,
    required String doctorName,
    required String doctorImg,
    required String prescriptionId,
    required String doctorDate,
    required List<DrugModel> drugModel,
  }) {
    emit(NewPrescriptionLoadingState());
    PrescriptionModel prescriptionModel = PrescriptionModel(doctorId: doctorId,
        doctorName: doctorName,
        doctorImg: doctorImg,
        prescriptionId: prescriptionId,
        doctorDate: doctorDate,
        drugModel: drugModel
        , dateTime: FieldValue.serverTimestamp());

    FirebaseFirestore.instance
        .collection('users')
        .doc(patientModel!.uId)
        .collection('prescriptionModel')
        .add(prescriptionModel.toJson())
        .then((value) {
      emit(NewPrescriptionSuccessState());
    }).catchError((error) {
      emit(NewPrescriptionErrorState());
    });
  }
}
