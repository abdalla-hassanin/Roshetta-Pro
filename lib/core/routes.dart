import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/core_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_new_prescription_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_new_x_ray_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_patient_medical_history_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_patient_prescriptions_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_patient_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_patient_x_rays_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_screen.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_settings_screen.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/doctor_auth/presentation/pages/doctor_sign_in_screen.dart';
import 'package:roshetta_pro/features/doctor_auth/presentation/pages/doctor_sign_up_screen.dart';
import 'package:roshetta_pro/features/patient/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_medical_history_screen.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_prescription_details_screen.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_prescriptions_screen.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_screen.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_settings_screen.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_x_rays_screen.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/pages/patient_sign_in_screen.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/pages/patient_sign_up_screen.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart'
    as pharmacy;
import 'package:roshetta_pro/features/pharmacy/presentation/pages/pharmacy_prescription_screen.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/pages/pharmacy_screen.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/pages/pharmacy_settings_screen.dart';
import 'package:roshetta_pro/features/pharmacy_auth/presentation/pages/pharmacy_sign_in_screen.dart';
import 'package:roshetta_pro/features/pharmacy_auth/presentation/pages/pharmacy_sign_up_screen.dart';

class Routes {
  static const String coreScreen = 'coreScreen';
  static const String pharmacySignInScreen = 'pharmacySignInScreen';
  static const String pharmacySignUpScreen = 'pharmacySignUpScreen';
  static const String pharmacyScreen = 'pharmacyScreen';
  static const String pharmacyPrescriptionScreen = 'pharmacyPrescriptionScreen';
  static const String pharmacySettingsScreen = 'pharmacySettingsScreen';

//////////////////////////////////////////////////////////////////////////
///////////////DOCTOR ROUTES////////////////////////////////////////////
  static const String doctorSignInScreen = 'doctorSignInScreen';
  static const String doctorSignUpScreen = 'doctorSignUpScreen';

  static const String doctorScreen = 'doctorScreen';

  static const String doctorSettingsScreen = 'doctorSettingsScreen';
  static const String doctorProfileScreen = 'doctorProfileScreen';
  static const String doctorNewPrescriptionScreen =
      'doctorNewPrescriptionScreen';

  static const String doctorPatientScreen = 'doctorPatientScreen';

  static const String doctorPatientPrescriptionsScreen ='doctorPatientPrescriptionsScreen';

  static const String doctorPatientMedicalHistoryScreen ='doctorPatientMedicalHistoryScreen';

  static const String doctorPatientXRaysScreen ='doctorPatientXRaysScreen';

  static const String doctorNewXRayScreen ='doctorNewXRayScreen';

//////////////////////////////////////////////////////////////////////////
///////////////PATIENT ROUTES////////////////////////////////////////////
  static const String patientSignInScreen = 'patientSignInScreen';
  static const String patientSignUpScreen = 'patientSignUpScreen';

  static const String patientScreen = 'patientScreen';
  static const String patientSettingsScreen = 'patientSettingsScreen';
  static const String patientPrescriptionsScreen = 'patientPrescriptionsScreen';
  static const String patientPrescriptionDetailsScreen =
      'patientPrescriptionDetailsScreen';
  static const String patientXRaysScreen = 'patientXRaysScreen';
  static const String patientMedicalHistoryScreen =
      'patientMedicalHistoryScreen';
}

class AppRoutes {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.coreScreen:
        return MaterialPageRoute(builder: (context) => const CoreScreen());
      case Routes.pharmacySignInScreen:
        return MaterialPageRoute(builder: (context) => PharmacySignInScreen());
      case Routes.pharmacySignUpScreen:
        return MaterialPageRoute(
            builder: (context) => const PharmacySingUpScreen());

      case Routes.pharmacyScreen:
        PharmacyEntity pharmacy = routeSettings.arguments as PharmacyEntity;
        return MaterialPageRoute(
            builder: (context) => PharmacyScreen(pharmacy));

      case Routes.pharmacyPrescriptionScreen:
        pharmacy.PrescriptionEntity prescription =
            routeSettings.arguments as pharmacy.PrescriptionEntity;
        return MaterialPageRoute(
            builder: (context) => PharmacyPrescriptionScreen(prescription));

      case Routes.pharmacySettingsScreen:
        return MaterialPageRoute(
            builder: (context) => const PharmacySettingsScreen());
///////////////////////////////////////////////////////////////////////////
///////////////DOCTOR ROUTES//////////////////////////////////////////////

      case Routes.doctorSignInScreen:
        return MaterialPageRoute(builder: (context) => DoctorSignInScreen());
      case Routes.doctorSignUpScreen:
        return MaterialPageRoute(
            builder: (context) => const DoctorSingUpScreen());

      case Routes.doctorScreen:
        DoctorEntity doctor = routeSettings.arguments as DoctorEntity;
        return MaterialPageRoute(builder: (context) => DoctorScreen(doctor));

      case Routes.doctorSettingsScreen:
        return MaterialPageRoute(
            builder: (context) => const DoctorSettingsScreen());
      case Routes.doctorNewPrescriptionScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DoctorNewPrescriptionScreen(patientId));

      case Routes.doctorPatientScreen:
        PatientEntity patientEntity = routeSettings.arguments as PatientEntity;
        return MaterialPageRoute(
            builder: (context) => DoctorPatientScreen(patientEntity));

      case Routes.doctorPatientPrescriptionsScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DoctorPatientPrescriptionsScreen(patientId));

      case Routes.doctorPatientMedicalHistoryScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DoctorPatientMedicalHistoryScreen(patientId));

      case Routes.doctorPatientXRaysScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DoctorPatientXRaysScreen(patientId));

      case Routes.doctorNewXRayScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => DoctorNewXRayScreen(patientId));
//////////////////////////////////////////////////////////////////////////
///////////////PATIENT ROUTES////////////////////////////////////////////

      case Routes.patientSignInScreen:
        return MaterialPageRoute(builder: (context) => PatientSignInScreen());
      case Routes.patientSignUpScreen:
        return MaterialPageRoute(
            builder: (context) => const PatientSingUpScreen());

      case Routes.patientScreen:
        PatientEntity patientEntity = routeSettings.arguments as PatientEntity;

        return MaterialPageRoute(
            builder: (context) => PatientScreen(patientEntity));
      case Routes.patientSettingsScreen:
        return MaterialPageRoute(
            builder: (context) => const PatientSettingsScreen());
      case Routes.patientPrescriptionsScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PatientPrescriptionsScreen(patientId));
      case Routes.patientPrescriptionDetailsScreen:
        PrescriptionEntity prescription =
            routeSettings.arguments as PrescriptionEntity;
        return MaterialPageRoute(
            builder: (context) =>
                PatientPrescriptionDetailsScreen(prescription));

      case Routes.patientXRaysScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PatientXRaysScreen(patientId));

      case Routes.patientMedicalHistoryScreen:
        String patientId = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PatientMedicalHistoryScreen(patientId));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      "data",
                    ),
                  ),
                ));
    }
  }
}
