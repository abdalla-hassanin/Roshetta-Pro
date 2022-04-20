import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_dialog_warning.dart';
import 'package:roshetta_pro/core/component/my_info_top_bar.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient/dr_all_prescriptions_screen.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient/dr_medical_history_screen.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient/dr_x_rays_analyzes_screen.dart';
import 'package:roshetta_pro/patient/screens/pa_profile_screen.dart';

class DoctorPatientLayout extends StatelessWidget {
  const DoctorPatientLayout({Key? key}) : super(key: key);

  clearScreen(DoctorCubit cubit) {
    cubit.patientModel = null;
    cubit.prescriptionModels.clear();
    cubit.medicalHistoryModels.clear();
    cubit.xRaysAnalysisModels.clear();
    cubit.popPostImage();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        var doctorCubit = DoctorCubit.get(context);
        List<Map<String, dynamic>> model = [
          {
            'title': LocaleKeys.prescriptions.tr(),
            'icon': 'assets/images/roshetta.png',
            'widget':  DrAllPrescriptionsScreen()
          },
          {
            'title': LocaleKeys.patientProfile.tr(),
            'icon': 'assets/images/profile_icon.png',
            'widget': PaProfileScreen(
              patientModel: doctorCubit.patientModel!,
            )
          },
          {
            'title': LocaleKeys.xRaysAnalysis.tr(),
            'icon': 'assets/images/x_rays.png',
            'widget': const DrXRaysAnalyzesScreen()
          },
          {
            'title': LocaleKeys.medicalHistory.tr(),
            'icon': 'assets/images/medical_history.png',
            'widget':  DrMedicalHistoryScreen()
          },
        ];
        return WillPopScope(
          onWillPop: () async {
            final shouldPop = await myDialogWarning(
                context: context,
                message: LocaleKeys.exitPatientProfile.tr(),
                onYesTap: () {
                  clearScreen(doctorCubit);
                  Navigator.pop(context, true);
                });
            return shouldPop ?? false;
          },
          child: Scaffold(
              appBar: myAppTopBar(
                  context: context,
                  title: LocaleKeys.patientProfile.tr()),
              body: Column(
                children: [
                  myInfoTopBar(
                      context: context,
                      image: doctorCubit.patientModel!.profileImg,
                      name: doctorCubit.patientModel!.name,
                      email: doctorCubit.patientModel!.email,
                      mobilePhone: doctorCubit.patientModel!.mobilePhone,
                      navigateToWidget: PaProfileScreen(
                        patientModel: doctorCubit.patientModel!,
                      )),
                  Expanded(
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 2.5,
                        crossAxisCount: 2,
                        mainAxisSpacing: 40.0,
                        crossAxisSpacing: 40.0,
                      ),
                      padding:
                          const EdgeInsets.only(top: 24, left: 16, right: 16),
                      children: [
                        _buildCard(
                            title: model[0]['title'],
                            icon: model[0]['icon'],
                            context: context,
                            widget: model[0]['widget']),
                        _buildCard(
                            title: model[1]['title'],
                            icon: model[1]['icon'],
                            context: context,
                            widget: model[1]['widget']),
                        _buildCard(
                            title: model[2]['title'],
                            icon: model[2]['icon'],
                            context: context,
                            widget: model[2]['widget']),
                        _buildCard(
                            title: model[3]['title'],
                            icon: model[3]['icon'],
                            context: context,
                            widget: model[3]['widget']),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    );
  }

  _buildCard(
      {required String title,
      required String icon,
      required BuildContext context,
      Widget? widget}) {
    return InkWell(
      onTap: () {
        if (widget != null) navigateTo(context, widget);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: colorGrayF9,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(icon),
            ),
            Text(title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'SST_Arabic',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: colorBlue4C,
                )),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
