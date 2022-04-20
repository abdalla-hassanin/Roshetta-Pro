import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:roshetta_pro/core/component/app_snackbar.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_info_top_bar.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_cubit.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_state.dart';
import 'package:roshetta_pro/pharmacy/screens/ph_profile_screen.dart';
import 'package:roshetta_pro/pharmacy/screens/ph_settings_screen.dart';
import 'package:roshetta_pro/pharmacy/screens/ph_prescription_screen.dart';

class PharmacyLayout extends StatelessWidget {
  PharmacyLayout({Key? key}) : super(key: key);
  final TextEditingController _patientPhoneController = TextEditingController();
  final TextEditingController _prescriptionIDController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit, PharmacyState>(
      listener: (context, state) {
        if( state is PatientPrescriptionModelErrorState ) {
          showToast('Please Enter Valid Data',
              'Error');
        }
      },
      builder: (context, state) {
        var pharmacyCubit = PharmacyCubit.get(context);
        return  Scaffold(
          appBar: myAppTopBarWithAction(
              context: context,
              title: LocaleKeys.roshettaPro.tr(),
              actionIcon: Majesticons.adjustments_line,
              leadingIcon: Carbon.notification_new,
              leadingOnTap: () {},
              actionOnTap: () {
                navigateTo(context, const PhSettingsScreen());
              }),
          body: ifConditional(
          context: context,
          conditionBuilder: (context) => pharmacyCubit.pharmacyModel != null,
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          widgetBuilder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  myInfoTopBar(
                      context: context,
                      image: pharmacyCubit.pharmacyModel!.profileImg,
                      name: pharmacyCubit.pharmacyModel!.name,
                      email: pharmacyCubit.pharmacyModel!.email,
                      mobilePhone: pharmacyCubit.pharmacyModel!.mobilePhone,
                      navigateToWidget: const PhProfileScreen()),
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
                          LocaleKeys.enterPatientPhonePrescriptionID.tr(),
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
                      ),),
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
                              myTextFormField(
                                context: context,
                                title: LocaleKeys.numberPhone.tr(),
                                hintText: LocaleKeys.numberPhone.tr(),
                                controller: _patientPhoneController,
                                prefix:  Ic.baseline_phone_enabled,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.thisFieldMustBeFilled
                                        .tr();
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              myTextFormField(
                                context: context,
                                title: LocaleKeys.prescriptionId.tr(),
                                hintText: LocaleKeys.prescriptionId.tr(),
                                controller: _prescriptionIDController,
                                prefix: Mdi.identifier,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.thisFieldMustBeFilled
                                        .tr();
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 30,
                              ),state is PatientPrescriptionModelLoadingState
                                  ? const Center(child: CircularProgressIndicator())
                                  :
                              myButton(
                                text: LocaleKeys.login.tr(),
                                onTap: () => _loginOnTap(context: context)
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  _loginOnTap({
    required BuildContext context
}) async {
    if (_formKey.currentState!.validate()) {
      await PharmacyCubit.get(context)
          .getPatientPrescriptionModel(
          mobilePhone:
          _patientPhoneController
              .text,
          prescriptionId:
          _prescriptionIDController.text)
          .then((value) async {
        if (PharmacyCubit.get(context)
            .prescriptionModel !=
            null) {
          await PharmacyCubit.get(context)
              .getDoctorModel(
              uId: PharmacyCubit.get(context)
                  .prescriptionModel!
                  .doctorId)
              .then((value) {
            navigateTo(
                context,
                PhPrescriptionScreen(
                  prescriptionModel:
                  PharmacyCubit.get(context)
                      .prescriptionModel!,
                  doctorModel: value,
                ));
          });
        }
      });
    }
  }
}
