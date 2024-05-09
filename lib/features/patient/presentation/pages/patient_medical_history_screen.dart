import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient/presentation/manager/patient_cubit.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_medical_history_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';

class PatientMedicalHistoryScreen extends StatelessWidget {
  final String patientId;

  const PatientMedicalHistoryScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PatientCubit>().getPatientMedicalHistory(patientId);
    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.medicalHistory),
        body: BlocConsumer<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is GetPatientMedicalHistoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is GetPatientMedicalHistorySuccess) {
              final medicalHistory = state.medicalHistory;

              if (medicalHistory.isEmpty) {
                return Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                );
              }
              return SingleChildScrollView(
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CustomMedicalHistoryCard(
                          image: medicalHistory[index].doctorImg,
                          doctorName: medicalHistory[index].doctorName,
                          date: medicalHistory[index].date,
                          bodyText: medicalHistory[index].body,
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                    itemCount: medicalHistory.length),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
