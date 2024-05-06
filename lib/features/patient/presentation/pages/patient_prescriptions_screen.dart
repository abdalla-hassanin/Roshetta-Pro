import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient/presentation/manager/patient_cubit.dart';
import 'package:roshetta_pro/features/patient/presentation/widgets/custom_prescription_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';

class PatientPrescriptionsScreen extends StatelessWidget {
  final String patientId;

  const PatientPrescriptionsScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PatientCubit>().getPatientPrescriptions(patientId);

    return Scaffold(
      appBar: CustomTopBar(title: context.l10n.prescriptions),
      body: BlocBuilder<PatientCubit, PatientState>(
        builder: (context, state) {
          if (state is GetPatientPrescriptionsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPatientPrescriptionsError) {
            //TODO: navigate back and show snack bar with error
            // Navigator.pop(context);
            return Center(
              child: Text(state.error),
            );
          } else if (state is GetPatientPrescriptionsSuccess) {
            final prescriptions = state.prescriptions;
            if (prescriptions.isEmpty) {
              return Center(
                child: Lottie.asset('assets/animation/no-data-preview.json'),
              );
            }
            return SingleChildScrollView(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => CustomPrescriptionCard(
                  image: prescriptions[index].doctorImg,
                  doctorName: prescriptions[index].doctorName,
                  date: prescriptions[index].doctorDate,
                  prescriptionID: prescriptions[index].prescriptionId,
                  numberDrugs: prescriptions[index].drugModel.length.toString(),
                  onTap: () {
                    Navigator.pushNamed(
                        context, Routes.patientPrescriptionDetailsScreen,
                        arguments: prescriptions[index]);
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: prescriptions.length,
              ),
            );
          } else {
            Navigator.pop(context);
            return Container();
          }
        },
      ),
    );
  }
}
