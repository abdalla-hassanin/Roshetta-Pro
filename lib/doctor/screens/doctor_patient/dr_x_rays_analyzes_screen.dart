import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_x_ray_card.dart';
import 'package:roshetta_pro/core/models/x_rays_analysis_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient/new_x_reays_ayalyzes_screen.dart';

class DrXRaysAnalyzesScreen extends StatefulWidget {
  const DrXRaysAnalyzesScreen({Key? key}) : super(key: key);

  @override
  State<DrXRaysAnalyzesScreen> createState() => _DrXRaysAnalyzesScreenState();
}

class _DrXRaysAnalyzesScreenState extends State<DrXRaysAnalyzesScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {},
        builder: (context, state) {
          DoctorCubit doctorCubit = DoctorCubit.get(context);
          List<XRaysAnalysisModel?> xRaysAnalysisModels =
              doctorCubit.xRaysAnalysisModels;
          return Scaffold(
              appBar:myAppTopBar(
                  context: context,
                  title: LocaleKeys.xRaysAnalysis.tr()),

              body: SmartRefresher(
                physics: const BouncingScrollPhysics(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: ifConditional(
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
                            doctorImage: xRaysAnalysisModels[index]!.doctorImg,
                            doctorName: xRaysAnalysisModels[index]!.doctorName,
                            date: xRaysAnalysisModels[index]!.date,
                            bodyText: xRaysAnalysisModels[index]!.notes),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        itemCount: xRaysAnalysisModels.length,
                      ),
                    ],
                  ),
                ),
              ),),
              floatingActionButton: FloatingActionButton.extended(
                hoverElevation: 50,
                backgroundColor: colorBlue4C,
                onPressed: () {
                  navigateTo(context, NewXRaysAnalysisScreen());
                },
                label: Text(
                  LocaleKeys.addXRay.tr(),
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: colorGrayF9,
                  ),
                ),
                icon: Iconify(Ic.baseline_add, color: colorBlueC0),
              ));
        });
  }
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      DoctorCubit.get(context).getXRaysAnalysisModel(uId: DoctorCubit.get(context).patientModel!.uId);
      _refreshController.refreshCompleted();
      debugPrint(DoctorCubit.get(context).xRaysAnalysisModels.length.toString());
    });
  }
}
