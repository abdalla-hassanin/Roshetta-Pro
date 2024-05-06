import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/patient/presentation/widgets/custom_x_ray_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';

class DoctorPatientXRaysScreen extends StatelessWidget {
  final String patientId;

  const DoctorPatientXRaysScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DoctorCubit>().getPatientXRays(patientId);
    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.xRaysAnalysis),
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            if (state is GetPatientXRaysLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPatientXRaysError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              });
              Navigator.pop(context);
              return Center(
                child: Text(state.error),
              );
            } else if (state is GetPatientXRaysSuccess) {
              final xRays = state.patientXRays;

              if (xRays.isEmpty) {
                return Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                );
              }
              return SingleChildScrollView(
                child: ListView.separated(
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
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          hoverElevation: 50,
          backgroundColor: colorBlue4C,
          onPressed: () {
            Navigator.pushNamed(context, Routes.doctorNewXRayScreen,
                arguments: patientId);
          },
          label: Text(
            context.l10n.addXRay,
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
