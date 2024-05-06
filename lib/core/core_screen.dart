import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/doctor_auth/presentation/manager/doctor_auth_cubit.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/manager/patient_auth_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy_auth/presentation/manager/pharmacy_auth_cubit.dart';

class CoreScreen extends StatelessWidget {
  const CoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        PatientAuthState patientAuthState =
            context.watch<PatientAuthCubit>().state;
        PharmacyAuthState pharmacyAuthState =
            context.watch<PharmacyAuthCubit>().state;
        DoctorAuthState doctorAuthState =
            context.watch<DoctorAuthCubit>().state;

        if (patientAuthState is GetPatientLoading ||
            pharmacyAuthState is GetPharmacyLoading ||
            doctorAuthState is GetDoctorLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (patientAuthState is GetPatientSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.patientScreen,
                arguments: patientAuthState.patientEntity,
                (route) => false);
          });
        } else if (pharmacyAuthState is GetPharmacySuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.pharmacyScreen,
                arguments: pharmacyAuthState.pharmacyEntity,
                (route) => false);
          });
        } else if (doctorAuthState is GetDoctorSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.doctorScreen,
              arguments: doctorAuthState.doctorEntity,
              (route) => false,
            );
          });
        }
        return Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              } else if (snapshot.hasData) {
                // User is signed in
                User user = snapshot.data!;
                getUserType(user).then((value) {
                  switch (value) {
                    case FireBaseEndPoints.patient:
                      context.read<PatientAuthCubit>().getPatient();
                    case FireBaseEndPoints.pharmacy:
                      context.read<PharmacyAuthCubit>().getPharmacy();
                    case FireBaseEndPoints.doctor:
                      context.read<DoctorAuthCubit>().getDoctor();
                    default:
                      break;
                  }
                });
              } else {
                // User is not signed in
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Choose your system',
                            style: TextStyle(fontSize: 24)),
                        const Text('to start using',
                            style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Pharmacy',
                          onTap: () => Navigator.pushNamed(
                              context, Routes.pharmacySignInScreen),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Patient',
                          onTap: () => Navigator.pushNamed(
                              context, Routes.patientSignInScreen),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Doctor',
                          onTap: () => Navigator.pushNamed(
                              context, Routes.doctorSignInScreen),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Future<String> getUserType(User user) async {
    return await FirebaseFirestore.instance
        .collection(FireBaseEndPoints.users)
        .doc(user.uid)
        .get()
        .then((value) => value.data()![FireBaseEndPoints.userType] as String);
  }


}
