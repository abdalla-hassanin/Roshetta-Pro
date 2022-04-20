import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_medical_history_card.dart';
import 'package:roshetta_pro/core/models/medical_history_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/patient/cubit/patient_cubit.dart';
import 'package:roshetta_pro/patient/cubit/patient_state.dart';

class PaMedicalHistoryScreen extends StatelessWidget {
  const PaMedicalHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
        listener: (context, state) {},
        builder: (context, state) {
          PatientCubit patientCubit = PatientCubit.get(context);

          List<MedicalHistoryModel?> medicalHistoryModels =
              patientCubit.medicalHistoryModels;
          return Scaffold(
              appBar: myAppTopBar(
                  context: context,
                  title: LocaleKeys.medicalHistory.tr()),
              body: ifConditional(
              context: context,
              conditionBuilder: (context) => medicalHistoryModels.isNotEmpty,
              fallbackBuilder: (context) => Center(
                    child:
                        Lottie.asset('assets/animation/no-data-preview.json'),
                  ),
              widgetBuilder: (context) => SingleChildScrollView(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => myMedicalHistoryCard(
                        context: context,
                        image: medicalHistoryModels[index]!.doctorImg,
                        doctorName: medicalHistoryModels[index]!.doctorName,
                        date: medicalHistoryModels[index]!.date,
                        bodyText: medicalHistoryModels[index]!.body,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount:medicalHistoryModels.length,
                    ),
                  )));
        });
  }
}
