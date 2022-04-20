import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_prescription_card.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';
import 'package:roshetta_pro/doctor/screens/doctor_patient/new_prescription_screen.dart';
import 'package:roshetta_pro/patient/screens/prescription_screen.dart';

class DrAllPrescriptionsScreen extends StatefulWidget {
   DrAllPrescriptionsScreen({Key? key}) : super(key: key);

  @override
  State<DrAllPrescriptionsScreen> createState() => _DrAllPrescriptionsScreenState();
}

class _DrAllPrescriptionsScreenState extends State<DrAllPrescriptionsScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {},
        builder: (context, state) {
          DoctorCubit doctorCubit = DoctorCubit.get(context);
          List<PrescriptionModel?> prescriptionModels =
              doctorCubit.prescriptionModels;
          return Scaffold(
              appBar: myAppTopBar(
                  context: context,
                  title: LocaleKeys.prescriptions.tr()),
              body:SmartRefresher(
                physics: const BouncingScrollPhysics(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child:  ifConditional(
                context: context,
                conditionBuilder: (context) => prescriptionModels.isNotEmpty,
                fallbackBuilder: (context) => Center(
                  child: Lottie.asset('assets/animation/no-data-preview.json'),
                ),
                widgetBuilder: (context) => SingleChildScrollView(
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
                          doctorCubit
                              .getPatientDoctorModel(
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
                ),
              ),),
              floatingActionButton: FloatingActionButton.extended(
                hoverElevation: 50,
                backgroundColor: colorBlue4C,
                onPressed: () {
                  navigateTo(context, const NewPrescriptionScreen());
                },
                label: Text(
                  LocaleKeys.addPrescription.tr(),
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
      DoctorCubit.get(context).getPrescriptionModel(uId: DoctorCubit.get(context).patientModel!.uId);
      _refreshController.refreshCompleted();
      debugPrint(DoctorCubit.get(context).prescriptionModels.length.toString());
    });
  }
}
