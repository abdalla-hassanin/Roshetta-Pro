import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_prescription_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';

class DoctorPatientPrescriptionsScreen extends StatelessWidget {
  final String patientId;

  const DoctorPatientPrescriptionsScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DoctorCubit>().getPatientPrescriptions(patientId);

    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.prescriptions),
        body: BlocConsumer<DoctorCubit, DoctorState>(
          listener: (context, state) {
            if (state is GetPatientPrescriptionsError) {
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
            if (state is GetPatientPrescriptionsSuccess) {
              final prescriptions = state.patientPrescriptions;
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
                    numberDrugs:
                        prescriptions[index].drugModel.length.toString(),
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.patientPrescriptionDetailsScreen,
                          arguments: prescriptions[index]);
                    },
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemCount: prescriptions.length,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          hoverElevation: 50,
          backgroundColor: colorBlue4C,
          onPressed: () {
            Navigator.pushNamed(context, Routes.doctorNewPrescriptionScreen,
                arguments: patientId);
          },
          label: Text(
            context.l10n.addPrescription,
            style: TextStyle(
              fontFamily: 'SST_Arabic',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: colorGrayF9,
            ),
          ),
          icon: Iconify(Ic.baseline_add, color: colorBlueC0),
        ));
  }
}
