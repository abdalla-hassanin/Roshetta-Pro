
import 'package:flutter/material.dart';

@immutable
abstract class PatientState {}

class PatientInitial extends PatientState {}

///User State
class PatientModelLoadingState extends PatientState{}
class PatientModelSuccessState extends PatientState {}
class PatientModelErrorState extends PatientState{}
///End of User State


class MedicalHistoryModelLoadingState extends PatientState{}
class MedicalHistoryModelSuccessState extends PatientState {}
class MedicalHistoryModelErrorState extends PatientState{}


class XRaysAnalysisModelLoadingState extends PatientState{}
class XRaysAnalysisModelSuccessState extends PatientState {}
class XRaysAnalysisModelErrorState extends PatientState{}


class PrescriptionModelLoadingState extends PatientState{}
class PrescriptionModelSuccessState extends PatientState {}
class PrescriptionModelErrorState extends PatientState{}


class DoctorIDModelLoadingState extends PatientState{}
class DoctorIDModelSuccessState extends PatientState {}
class DoctorIDModelErrorState extends PatientState{}
