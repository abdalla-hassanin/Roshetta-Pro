import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/core/models/patient_model.dart';
import 'package:roshetta_pro/core/models/pharmacy_model.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PatientInitial());

  static PharmacyCubit get(context) => BlocProvider.of(context);

  PharmacyModel? pharmacyModel;

  Future getPharmacyModel({required String uId}) async {
    emit(PharmacyModelLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      pharmacyModel = PharmacyModel.fromJson(value.data()!);
      if (kDebugMode) {
        print(pharmacyModel!.toJson());
      }
      emit(PharmacyModelSuccessState());
    }).catchError((error) {
      emit(PharmacyModelErrorState());
    });
  }

  PrescriptionModel? prescriptionModel;
  PatientModel? patientModel;

  Future getPatientPrescriptionModel(
      {required String mobilePhone, required String prescriptionId})
  async {
    emit(PatientPrescriptionModelLoadingState());
    await  FirebaseFirestore.instance
        .collection('users')
        .where('mobilePhone', isEqualTo: mobilePhone)
        .get()
        .then((value) async {
      patientModel = PatientModel.fromJson(value.docs[0].data());
      await  FirebaseFirestore.instance
          .collection('users')
          .doc(patientModel!.uId)
          .collection('prescriptionModel')
          .where('prescriptionId', isEqualTo: prescriptionId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          prescriptionModel = PrescriptionModel.fromJson(value.docs[0].data());
          emit(PatientPrescriptionModelSuccessState());
        }
      });
    }).catchError((error) {
      emit(PatientPrescriptionModelErrorState());
    });
  }

  Future getDoctorModel({required String uId}) async {
    DoctorModel? doctorModel;

    emit(DoctorIDModelLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
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
  }
}
