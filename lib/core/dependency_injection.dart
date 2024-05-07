import 'package:get_it/get_it.dart';
import 'package:roshetta_pro/features/auth/data/data_sources/auth_data_source.dart';
import 'package:roshetta_pro/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:roshetta_pro/features/auth/domain/repositories/auth_repository.dart';
import 'package:roshetta_pro/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:roshetta_pro/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:roshetta_pro/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:roshetta_pro/features/doctor/domain/use_cases/doctor_use_cases.dart';
import 'package:roshetta_pro/features/patient/data/data_sources/patient_data_source.dart';
import 'package:roshetta_pro/features/patient/data/repositories/patient_repository_impl.dart';
import 'package:roshetta_pro/features/patient/domain/repositories/patient_repository.dart';
import 'package:roshetta_pro/features/patient/domain/use_cases/patient_use_cases.dart';
import 'package:roshetta_pro/features/pharmacy/data/data_sources/pharmacy_data_source.dart';
import 'package:roshetta_pro/features/pharmacy/domain/repositories/pharmacy_repository.dart';
import 'package:roshetta_pro/features/pharmacy/domain/use_cases/pharmacy_use_cases.dart';

import '../features/doctor/data/data_sources/doctor_data_source.dart';
import '../features/pharmacy/data/repositories/pharmacy_repository_impl.dart';

final GetIt getIt = GetIt.instance;

void setupDI() {
  /// ///////////////////////AUTH DI ///////////////////////////////////////////////
  getIt.registerLazySingleton<AuthDataSource>(
      () => AuthDataSource());

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt()));

  getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(getIt()));

  getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(getIt()));

  getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(getIt()));

  getIt.registerLazySingleton<UploadImageToStorageUseCase>(
      () => UploadImageToStorageUseCase(getIt()));

  getIt.registerLazySingleton<DoctorSignUpUseCase>(
      () => DoctorSignUpUseCase(getIt()));

  getIt.registerLazySingleton<GetDoctorUseCase>(
      () => GetDoctorUseCase(getIt()));

  getIt.registerLazySingleton<PatientSignUpUseCase>(
      () => PatientSignUpUseCase(getIt()));

  getIt.registerLazySingleton<GetPatientUseCase>(
      () => GetPatientUseCase(getIt()));

  getIt.registerLazySingleton<PharmacySignUpUseCase>(
      () => PharmacySignUpUseCase(getIt()));

  getIt.registerLazySingleton<GetPharmacyUseCase>(
      () => GetPharmacyUseCase(getIt()));


  /// ///////////////////////////////////////////////////////////////////////////////////
  /// /////////////////////// PHARMACY DI ///////////////////////////////////////////////

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
