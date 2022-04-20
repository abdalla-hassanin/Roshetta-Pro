import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_info_top_bar.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/patient/cubit/patient_cubit.dart';
import 'package:roshetta_pro/patient/cubit/patient_state.dart';
import 'package:roshetta_pro/patient/screens/pa_all_prescriptions_screen.dart';
import 'package:roshetta_pro/patient/screens/pa_medical_history_screen.dart';
import 'package:roshetta_pro/patient/screens/pa_profile_screen.dart';
import 'package:roshetta_pro/patient/screens/pa_settings_screen.dart';
import 'package:roshetta_pro/patient/screens/pa_x_rays_analyzes_screen.dart';

class PatientLayout extends StatelessWidget {
  PatientLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var patientCubit = PatientCubit.get(context);
        List<Map<String, dynamic>> model = [
          {
            'title': LocaleKeys.prescriptions.tr(),
            'icon': 'assets/images/roshetta.png',
            'widget': const PaAllPrescriptionsScreen()
          },
          {
            'title': LocaleKeys.alerts.tr(),
            'icon': 'assets/images/alarm.png',
            'widget': null
          },
          {
            'title': LocaleKeys.xRaysAnalysis.tr(),
            'icon': 'assets/images/x_rays.png',
            'widget': const PaXRaysAnalyzesScreen()
          },
          {
            'title': LocaleKeys.medicalHistory.tr(),
            'icon': 'assets/images/medical_history.png',
            'widget': const PaMedicalHistoryScreen()
          },
        ];
        return Scaffold(
          appBar: myAppTopBarWithAction(
              context: context,
              title: LocaleKeys.roshettaPro.tr(),
              actionIcon: Majesticons.adjustments_line,
              leadingIcon: Carbon.notification_new,
              leadingOnTap: () {},
              actionOnTap: () {
                navigateTo(context, const PaSettingsScreen());
              }),
          body: ifConditional(
              context: context,
              conditionBuilder: (context) => patientCubit.patientModel != null,
              fallbackBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              widgetBuilder: (context) => Column(
                    children: [
                      myInfoTopBar(
                          context: context,
                          image: patientCubit.patientModel!.profileImg,
                          name: patientCubit.patientModel!.name,
                          email: patientCubit.patientModel!.email,
                          mobilePhone: patientCubit.patientModel!.mobilePhone,
                          navigateToWidget: PaProfileScreen(
                            patientModel: patientCubit.patientModel!,
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
                          padding: const EdgeInsets.only(
                              top: 24, left: 16, right: 16),
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
