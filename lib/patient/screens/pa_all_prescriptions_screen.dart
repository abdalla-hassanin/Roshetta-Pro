import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_prescription_card.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/patient/cubit/patient_cubit.dart';
import 'package:roshetta_pro/patient/cubit/patient_state.dart';
import 'package:roshetta_pro/patient/screens/prescription_screen.dart';

class PaAllPrescriptionsScreen extends StatelessWidget {
  const PaAllPrescriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        PatientCubit patientCubit = PatientCubit.get(context);
        List<PrescriptionModel?> prescriptionModels =
            patientCubit.prescriptionModels;
        return Scaffold(
            appBar: myAppTopBar(
                context: context,
                title: LocaleKeys.prescriptions.tr()),

            body: ifConditional(
            context: context,
            conditionBuilder: (context) => prescriptionModels.isNotEmpty,
            fallbackBuilder: (context) => Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                ),
            widgetBuilder: (context) =>  SingleChildScrollView(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => myPrescriptionCard(
                        context: context,
                        image: prescriptionModels[index]!.doctorImg,
                        doctorName: prescriptionModels[index]!.doctorName,
                        date: prescriptionModels[index]!.doctorDate,
                        prescriptionID:
                            prescriptionModels[index]!.prescriptionId,
                        numberDrugs: prescriptionModels[index]!
                            .drugModel
                            .length
                            .toString(),
                        onTap: () {
                          patientCubit
                              .getDoctorModel(
                                  uId: prescriptionModels[index]!.doctorId)
                              .then((value) {
                            navigateTo(
                                context,
                                PrescriptionScreen(
                                  prescriptionModel: prescriptionModels[index]!,
                                  doctorModel: value,
                                ));
                          });
                        }),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: prescriptionModels.length,
                  ),
                )));
      },
    );
  }
}
