import 'package:get_it/get_it.dart';
import 'package:roshetta_pro/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:roshetta_pro/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:roshetta_pro/features/doctor/domain/use_cases/doctor_use_cases.dart';
import 'package:roshetta_pro/features/doctor_auth/data/data_sources/doctor_auth_data_source.dart';
import 'package:roshetta_pro/features/doctor_auth/data/repositories/doctor_auth_repository_impl.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/repositories/doctor_auth_repository.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/use_cases/doctor_auth_use_cases.dart';
import 'package:roshetta_pro/features/patient/data/data_sources/patient_data_source.dart';
import 'package:roshetta_pro/features/patient/data/repositories/patient_repository_impl.dart';
import 'package:roshetta_pro/features/patient/domain/repositories/patient_repository.dart';
import 'package:roshetta_pro/features/patient/domain/use_cases/patient_use_cases.dart';
import 'package:roshetta_pro/features/patient_auth/data/data_sources/patient_auth_data_source.dart';
import 'package:roshetta_pro/features/patient_auth/data/repositories/patient_auth_repository_impl.dart';
import 'package:roshetta_pro/features/patient_auth/domain/repositories/patient_auth_repository.dart';
import 'package:roshetta_pro/features/patient_auth/domain/use_cases/patient_auth_use_cases.dart';
import 'package:roshetta_pro/features/pharmacy/data/data_sources/pharmacy_data_source.dart';
import 'package:roshetta_pro/features/pharmacy/domain/repositories/pharmacy_repository.dart';
import 'package:roshetta_pro/features/pharmacy/domain/use_cases/pharmacy_use_cases.dart';
import 'package:roshetta_pro/features/pharmacy_auth/data/data_sources/pharmacy_auth_data_source.dart';
import 'package:roshetta_pro/features/pharmacy_auth/data/repositories/pharmacy_auth_repository_impl.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/repositories/pharmacy_auth_repository.dart';
import 'package:roshetta_pro/features/pharmacy_auth/domain/use_cases/pharmacy_auth_use_cases.dart';

import '../features/doctor/data/data_sources/doctor_data_source.dart';
import '../features/pharmacy/data/repositories/pharmacy_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setupDI() {
  /// ///////////////////////////////////////////////////////////////////////////////////
  /// /////////////////////// PHARMACY DI ///////////////////////////////////////////////
  /// Register Auth
  getIt.registerLazySingleton<PharmacyAuthDataSource>(
      () => PharmacyAuthDataSource());

  getIt.registerLazySingleton<PharmacyAuthRepository>(
      () => PharmacyAuthRepositoryImpl(getIt()));

  getIt.registerLazySingleton<PharmacySignInUseCase>(
      () => PharmacySignInUseCase(getIt()));

  getIt.registerLazySingleton<PharmacySignUpUseCase>(
      () => PharmacySignUpUseCase(getIt()));

  getIt.registerLazySingleton<PharmacyUploadImageToStorageUseCase>(
      () => PharmacyUploadImageToStorageUseCase(getIt()));
  getIt.registerLazySingleton<PharmacySignOutUseCase>(
      () => PharmacySignOutUseCase(getIt()));

  getIt.registerLazySingleton<PharmacyForgotPasswordUseCase>(
      () => PharmacyForgotPasswordUseCase(getIt()));

  getIt.registerLazySingleton<GetPharmacyUseCase>(
      () => GetPharmacyUseCase(getIt()));

  // Register Pharmacy

  // Register data sources
  getIt.registerLazySingleton<PharmacyDataSource>(() => PharmacyDataSource());

  // Register repositories
  getIt.registerLazySingleton<PharmacyRepository>(
      () => PharmacyRepositoryImpl(getIt()));

  getIt.registerLazySingleton<
          GetPrescriptionByUserPhoneAndPrescriptionIdUseCase>(
      () => GetPrescriptionByUserPhoneAndPrescriptionIdUseCase(getIt()));

  /// ////////////////////////////////////////////////////////////////////////////////////
  /// /////////////////////// DOCTOR DI /////////////////////////////////////////////////

  getIt.registerLazySingleton<DoctorAuthDataSource>(
      () => DoctorAuthDataSource());

  getIt.registerLazySingleton<DoctorAuthRepository>(
      () => DoctorAuthRepositoryImpl(getIt()));

  getIt.registerLazySingleton<DoctorSignInUseCase>(
      () => DoctorSignInUseCase(getIt()));

  getIt.registerLazySingleton<DoctorSignUpUseCase>(
      () => DoctorSignUpUseCase(getIt()));

  getIt.registerLazySingleton<DoctorUploadImageToStorageUseCase>(
      () => DoctorUploadImageToStorageUseCase(getIt()));
  getIt.registerLazySingleton<DoctorSignOutUseCase>(
      () => DoctorSignOutUseCase(getIt()));

  getIt.registerLazySingleton<DoctorForgotPasswordUseCase>(
      () => DoctorForgotPasswordUseCase(getIt()));

  getIt
      .registerLazySingleton<GetDoctorUseCase>(() => GetDoctorUseCase(getIt()));

  // Register data sources
  getIt.registerLazySingleton<DoctorDataSource>(() => DoctorDataSource());

  getIt.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(getIt()));

  getIt.registerLazySingleton<GetPatientByMobileNumberUseCase>(
      () => GetPatientByMobileNumberUseCase(getIt()));

  getIt.registerLazySingleton<GetDPatientPrescriptionsUseCase>(
      () => GetDPatientPrescriptionsUseCase(getIt()));

  getIt.registerLazySingleton<GetDPatientXRaysUseCase>(
      () => GetDPatientXRaysUseCase(getIt()));

  getIt.registerLazySingleton<GetDPatientMedicalHistoryUseCase>(
      () => GetDPatientMedicalHistoryUseCase(getIt()));

  getIt.registerLazySingleton<AddNewPrescriptionUseCase>(
      () => AddNewPrescriptionUseCase(getIt()));

  getIt.registerLazySingleton<AddNewXRayUseCase>(
      () => AddNewXRayUseCase(getIt()));

  getIt.registerLazySingleton<AddNewMedicalHistoryUseCase>(
      () => AddNewMedicalHistoryUseCase(getIt()));

  getIt.registerLazySingleton<XRayUploadImageToStorageUseCase>(
      () => XRayUploadImageToStorageUseCase(getIt()));

  /// ////////////////////////////////////////////////////////////////////////////////////
  /// /////////////////////// PATIENT DI /////////////////////////////////////////////////

  getIt.registerLazySingleton<PatientAuthDataSource>(
      () => PatientAuthDataSource());

  getIt.registerLazySingleton<PatientAuthRepository>(
      () => PatientAuthRepositoryImpl(getIt()));

  getIt.registerLazySingleton<PatientSignInUseCase>(
      () => PatientSignInUseCase(getIt()));

  getIt.registerLazySingleton<PatientSignUpUseCase>(
      () => PatientSignUpUseCase(getIt()));

  getIt.registerLazySingleton<PatientUploadImageToStorageUseCase>(
      () => PatientUploadImageToStorageUseCase(getIt()));
  getIt.registerLazySingleton<PatientSignOutUseCase>(
      () => PatientSignOutUseCase(getIt()));

  getIt.registerLazySingleton<PatientForgotPasswordUseCase>(
      () => PatientForgotPasswordUseCase(getIt()));

  getIt.registerLazySingleton<GetPatientUseCase>(
      () => GetPatientUseCase(getIt()));

  getIt.registerLazySingleton<PatientDataSource>(() => PatientDataSource());

  getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(getIt()));

  getIt.registerLazySingleton<GetPatientPrescriptionsUseCase>(
      () => GetPatientPrescriptionsUseCase(getIt()));

  getIt.registerLazySingleton<GetPatientXRaysUseCase>(
      () => GetPatientXRaysUseCase(getIt()));

  getIt.registerLazySingleton<GetPatientMedicalHistoryUseCase>(
      () => GetPatientMedicalHistoryUseCase(getIt()));
}
