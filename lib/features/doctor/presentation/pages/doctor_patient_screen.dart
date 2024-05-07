import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient/presentation/pages/patient_profile_screen.dart';
import 'package:roshetta_pro/features/auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_info_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';

class DoctorPatientScreen extends StatelessWidget {
  final PatientEntity patientEntity;

  const DoctorPatientScreen(this.patientEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBar(title: context.l10n.patientProfile),
      body: Column(
        children: [
          CustomInfoCard(
              image: patientEntity.imageUrl,
              name: patientEntity.name,
              email: patientEntity.email,
              mobilePhone: patientEntity.mobileNumber,
              navigateToWidget: PatientProfileScreen(patientEntity)),
          Expanded(
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 2.5,
                crossAxisCount: 2,
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 40.0,
              ),
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              children: [
                _buildCard(
                    title: context.l10n.prescriptions,
                    icon: 'assets/images/roshetta.png',
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.doctorPatientPrescriptionsScreen,
                          arguments: patientEntity.uId);
                    }),
                _buildCard(
                  title: context.l10n.alerts,
                  icon: 'assets/images/alarm.png',
                  onTap: null,
                ),
                _buildCard(
                    title: context.l10n.xRaysAnalysis,
                    icon: 'assets/images/x_rays.png',
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.doctorPatientXRaysScreen,
                          arguments: patientEntity.uId);
                    }),
                _buildCard(
                    title: context.l10n.medicalHistory,
                    icon: 'assets/images/medical_history.png',
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.doctorPatientMedicalHistoryScreen,
                          arguments: patientEntity.uId);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCard({
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
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
