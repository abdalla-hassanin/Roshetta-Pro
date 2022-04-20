import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_x_ray_card.dart';
import 'package:roshetta_pro/core/models/x_rays_analysis_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/patient/cubit/patient_cubit.dart';
import 'package:roshetta_pro/patient/cubit/patient_state.dart';

class PaXRaysAnalyzesScreen extends StatelessWidget {
  const PaXRaysAnalyzesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit, PatientState>(
      listener: (context, state) {},
      builder: (context, state) {
        PatientCubit patientCubit = PatientCubit.get(context);
        List<XRaysAnalysisModel?> xRaysAnalysisModels =
            patientCubit.xRaysAnalysisModels;
        return Scaffold(
            appBar: myAppTopBar(
                context: context,
                title: LocaleKeys.xRaysAnalysis.tr()),
            body: ifConditional(
            context: context,
            conditionBuilder: (context) => xRaysAnalysisModels.isNotEmpty,
            fallbackBuilder: (context) => Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                ),
            widgetBuilder: (context) => SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => myXRayCard(
                              context: context,
                              xrayImage: xRaysAnalysisModels[index]!.xRayImg,
                              xrayName: xRaysAnalysisModels[index]!.xRayTitle,
                              xrayLab: xRaysAnalysisModels[index]!.labName,
                              doctorImage:xRaysAnalysisModels[index]!.doctorImg,
                              doctorName: xRaysAnalysisModels[index]!.doctorName,
                              date: xRaysAnalysisModels[index]!.date,
                              bodyText:
                              xRaysAnalysisModels[index]!.notes),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemCount: xRaysAnalysisModels.length,
                        ),
                      ],
                    ),
                  ),
                ));
      },
    );
  }

}
