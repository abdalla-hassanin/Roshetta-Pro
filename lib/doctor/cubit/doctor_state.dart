
import 'package:flutter/material.dart';

@immutable
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}


class DoctorModelLoadingState extends DoctorState{}
class DoctorModelSuccessState extends DoctorState {}
class DoctorModelErrorState extends DoctorState{}







class PatientDoctorIDModelLoadingState extends DoctorState{}
class PatientDoctorIDModelSuccessState extends DoctorState {}
class PatientDoctorIDModelErrorState extends DoctorState{}





///User State
class PatientModelLoadingState extends DoctorState{}
class PatientModelSuccessState extends DoctorState {}
class PatientModelErrorState extends DoctorState{}
///End of User State


class MedicalHistoryModelLoadingState extends DoctorState{}
class MedicalHistoryModelSuccessState extends DoctorState {}
class MedicalHistoryModelErrorState extends DoctorState{}

class HistoryDoctorModelLoadingState extends DoctorState{}
class HistoryDoctorModelSuccessState extends DoctorState {}
class HistoryDoctorModelErrorState extends DoctorState{}



class XRaysAnalysisModelLoadingState extends DoctorState{}
class XRaysAnalysisModelSuccessState extends DoctorState {}
class XRaysAnalysisModelErrorState extends DoctorState{}


class PrescriptionModelLoadingState extends DoctorState{}
class PrescriptionModelSuccessState extends DoctorState {}
class PrescriptionModelErrorState extends DoctorState{}


class DrugModelLoadingState extends DoctorState{}
class DrugModelSuccessState extends DoctorState {}
class DrugModelErrorState extends DoctorState{}


class NewMedicalHistoryLoadingState extends DoctorState{}
class NewMedicalHistorySuccessState extends DoctorState {}
class NewMedicalHistoryErrorState extends DoctorState{}
class NewPrescriptionLoadingState extends DoctorState{}
class NewPrescriptionSuccessState extends DoctorState {}
class NewPrescriptionErrorState extends DoctorState{}



class NewXRaysAnalysisLoadingState extends DoctorState{}
class NewXRaysAnalysisSuccessState extends DoctorState {}
class NewXRaysAnalysisErrorState extends DoctorState{}


class GetXRaysPicSuccessState extends DoctorState {}
class GetXRaysPicErrorState extends DoctorState{}
class DeleteXRaysPicState extends DoctorState {}


class AddDrugModelState extends DoctorState{}
