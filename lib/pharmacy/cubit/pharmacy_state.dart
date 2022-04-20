
import 'package:flutter/material.dart';

@immutable
abstract class PharmacyState {}

class PatientInitial extends PharmacyState {}

class PharmacyModelLoadingState extends PharmacyState{}
class PharmacyModelSuccessState extends PharmacyState {}
class PharmacyModelErrorState extends PharmacyState{}

class PatientPrescriptionModelLoadingState extends PharmacyState{}
class PatientPrescriptionModelSuccessState extends PharmacyState {}
class PatientPrescriptionModelErrorState extends PharmacyState{}

class DoctorIDModelLoadingState extends PharmacyState{}
class DoctorIDModelSuccessState extends PharmacyState {}
class DoctorIDModelErrorState extends PharmacyState{}
