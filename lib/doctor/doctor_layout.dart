import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/majesticons.dart';
import 'package:roshetta_pro/core/component/app_snackbar.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_info_top_bar.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient_layout.dart';
import 'package:roshetta_pro/doctor/screens/dr_profile_screen.dart';
import 'package:roshetta_pro/doctor/screens/dr_settings_screen.dart';

class DoctorLayout extends StatelessWidget {
  DoctorLayout({Key? key}) : super(key: key);
  final TextEditingController _patientPhoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if( state is PatientModelErrorState ) {
          showToast('Please Enter Valid Data',
              'Error');
        }
      },
      builder: (context, state) {
        var doctorCubit = DoctorCubit.get(context);
        return  Scaffold(
          appBar: myAppTopBarWithAction(
              context: context,
              title: LocaleKeys.roshettaPro.tr(),
              actionIcon: Majesticons.adjustments_line,
              leadingIcon: Carbon.notification_new,
              leadingOnTap: () {},
              actionOnTap: () {
                navigateTo(context, const DrSettingsScreen());
              }),
          body: ifConditional(
          context: context,
          conditionBuilder: (context) => doctorCubit.doctorModel != null,
          fallbackBuilder: (context) =>
              const Center(child: CircularProgressIndicator()),
          widgetBuilder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  myInfoTopBar(
                      context: context,
                      image: doctorCubit.doctorModel!.profileImg,
                      name: doctorCubit.doctorModel!.name,
                      email: doctorCubit.doctorModel!.email,
                      mobilePhone: doctorCubit.doctorModel!.mobilePhone,
                      navigateToWidget: DrProfileScreen(
                        doctorModel: doctorCubit.doctorModel!,
                      )),
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
                            LocaleKeys.enterPatientPhone.tr(),
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
                                hintText:LocaleKeys.numberPhone.tr(),
                                controller: _patientPhoneController,
                                prefix: Ic.baseline_phone_enabled,
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
                                height: 30,
                              ),state is PatientModelLoadingState
                                  ? const Center(child: CircularProgressIndicator())
                                  :
                              myButton(
                                text: LocaleKeys.login.tr(),
                                onTap: () => _loginOnTap(context: context),
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
      await DoctorCubit.get(context)
          .getPatientModel(
          mobilePhone:
          _patientPhoneController
              .text)
          .then((value) {
        if (DoctorCubit.get(context).patientModel != null) {
          _patientPhoneController.clear();
          navigateTo(context,
              const DoctorPatientLayout());

        }
      });
    }
  }
}
