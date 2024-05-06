import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient/presentation/manager/patient_cubit.dart';
import 'package:roshetta_pro/features/patient/presentation/widgets/custom_x_ray_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';

class PatientXRaysScreen extends StatelessWidget {
  final String patientId;

  const PatientXRaysScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PatientCubit>().getPatientXRays(patientId);

    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.xRaysAnalysis),
        body: BlocBuilder<PatientCubit, PatientState>(
          builder: (context, state) {
            if (state is GetPatientXRaysLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPatientXRaysError) {
              //TODO: navigate back and show snack bar with error
              // Navigator.pop(context);
              return Center(
                child: Text(state.error),
              );
            } else if (state is GetPatientXRaysSuccess) {
              final xRays = state.xrays;

              if (xRays.isEmpty) {
                return Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => CustomXRayCard(
                            xrayImage: xRays[index].xRayImg,
                            xrayName: xRays[index].xRayTitle,
                            xrayLab: xRays[index].labName,
                            doctorImage: xRays[index].doctorImg,
                            doctorName: xRays[index].doctorName,
                            date: xRays[index].date,
                            bodyText: xRays[index].notes),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            ),
                        itemCount: xRays.length),
                  ],
                ),
              );
            } else {
              Navigator.pop(context);
              return Container();
            }
          },
        ));
  }
}
