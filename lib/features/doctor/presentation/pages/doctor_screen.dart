import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/doctor/presentation/pages/doctor_profile_screen.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_button.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_info_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_text_form_field.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar_with_action.dart';

class DoctorScreen extends StatelessWidget {
  final DoctorEntity doctorEntity;

  DoctorScreen(this.doctorEntity, {super.key});

  final TextEditingController _patientPhoneController = TextEditingController();
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
            Navigator.pushNamed(context, Routes.doctorSettingsScreen);
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInfoCard(
                image: doctorEntity.imageUrl,
                name: doctorEntity.name,
                email: doctorEntity.email,
                mobilePhone: doctorEntity.mobilePhone,
                navigateToWidget: DoctorProfileScreen(doctorEntity)),
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
                    context.l10n.enterPatientPhone,
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
                        height: 30,
                      ),
                      BlocConsumer<DoctorCubit, DoctorState>(
                        listener: (context, state) {
                          if (state is GetPatientByMobileNumberError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } else if (state is GetPatientByMobileNumberSuccess) {
                            Navigator.pushNamed(
                                context, Routes.doctorPatientScreen,
                                arguments: state.patientEntity);
                            _formKey.currentState!.reset();
                          }
                        },
                        builder: (context, state) {
                          if (state is GetPatientByMobileNumberLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return CustomButton(
                            text: context.l10n.login,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final String mobileNumber =
                                    _patientPhoneController.text;
                                context
                                    .read<DoctorCubit>()
                                    .getPatientByMobileNumber(mobileNumber);
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
