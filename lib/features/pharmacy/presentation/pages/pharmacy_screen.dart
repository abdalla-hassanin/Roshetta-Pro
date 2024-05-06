import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/manager/pharmacy_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/pages/pharmacy_profile_screen.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_info_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_text_form_field.dart';

import '../widgets/custom_top_bar_with_action.dart';

class PharmacyScreen extends StatelessWidget {
  final PharmacyEntity pharmacyEntity;

  PharmacyScreen(this.pharmacyEntity, {super.key});

  final TextEditingController _patientPhoneController = TextEditingController();
  final TextEditingController _prescriptionIDController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopBarWithAction(
          title: context.l10n.roshettaPro,
          actionIcon: Majesticons.adjustments_line,
          leadingIcon: Carbon.notification_new,
          leadingOnTap: () {},
          actionOnTap: () {
            Navigator.pushNamed(context, Routes.pharmacySettingsScreen);
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInfoCard(
                image: pharmacyEntity.imageUrl,
                name: pharmacyEntity.name,
                email: pharmacyEntity.email,
                mobilePhone: pharmacyEntity.mobilePhone,
                navigateToWidget: PharmacyProfileScreen(pharmacyEntity)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorBlueC0,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    context.l10n.enterPatientPhonePrescriptionID,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w900,
                      wordSpacing: 1.5,
                      letterSpacing: 1.7,
                      fontSize: 24,
                      color: colorGrayF9,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorGrayF9,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        title: context.l10n.numberPhone,
                        hintText: context.l10n.numberPhone,
                        controller: _patientPhoneController,
                        prefix: Ic.baseline_phone_enabled,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomTextFormField(
                        title: context.l10n.prescriptionId,
                        hintText: context.l10n.prescriptionId,
                        controller: _prescriptionIDController,
                        prefix: Mdi.identifier,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<PharmacyCubit, PharmacyState>(
                        builder: (context, state) {
                          if (state
                              is GetPrescriptionByUserPhoneAndPrescriptionIdLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state
                              is GetPrescriptionByUserPhoneAndPrescriptionIdError) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            });
                          }
                          if (state
                              is GetPrescriptionByUserPhoneAndPrescriptionIdSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushNamed(
                                  context, Routes.pharmacyPrescriptionScreen,
                                  arguments: state.prescription);
                              _formKey.currentState!.reset();
                            })  ;

                          }
                          return CustomButton(
                            text: context.l10n.login,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final String patientPhone =
                                    _patientPhoneController.text;
                                final String prescriptionID =
                                    _prescriptionIDController.text;
                                context
                                    .read<PharmacyCubit>()
                                    .getPrescriptionByUserPhoneAndPrescriptionId(
                                        patientPhone, prescriptionID);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
