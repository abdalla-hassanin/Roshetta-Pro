import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_medical_history_card.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/models/medical_history_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';

class DrMedicalHistoryScreen extends StatefulWidget {
  DrMedicalHistoryScreen({Key? key}) : super(key: key);

  @override
  State<DrMedicalHistoryScreen> createState() => _DrMedicalHistoryScreenState();
}

class _DrMedicalHistoryScreenState extends State<DrMedicalHistoryScreen> {
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(listener: (context, state) {
      if (state is NewMedicalHistorySuccessState) {
        pop(context);
      }
    }, builder: (context, state) {
      DoctorCubit doctorCubit = DoctorCubit.get(context);
      List<MedicalHistoryModel?> medicalHistoryModels =
          doctorCubit.medicalHistoryModels;
      return Scaffold(
          appBar: myAppTopBar(
              context: context, title: LocaleKeys.medicalHistory.tr()),
          body:SmartRefresher(
            physics: const BouncingScrollPhysics(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ifConditional(
            context: context,
            conditionBuilder: (context) => medicalHistoryModels.isNotEmpty,
            fallbackBuilder: (context) => Center(
              child: Lottie.asset('assets/animation/no-data-preview.json'),
            ),
            widgetBuilder: (context) =>  SingleChildScrollView(
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
                  itemCount: medicalHistoryModels.length,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            hoverElevation: 50,
            backgroundColor: colorBlue4C,
            onPressed: () {
              _showDialog(context, doctorCubit);
            },
            label: Text(
              LocaleKeys.addMedicalHistory.tr(),
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

  void _showDialog(context, DoctorCubit doctorCubit) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            backgroundColor: colorGrayF9,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: MedicalHistoryDialog(
              doctorCubit: doctorCubit,
            ));
      },
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      DoctorCubit.get(context).getMedicalHistoryModel(uId: DoctorCubit.get(context).patientModel!.uId);
      _refreshController.refreshCompleted();
      debugPrint(DoctorCubit.get(context).medicalHistoryModels.length.toString());
    });
  }
}

class MedicalHistoryDialog extends StatelessWidget {
  final DoctorCubit doctorCubit;

  MedicalHistoryDialog({Key? key, required this.doctorCubit}) : super(key: key);
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: myTextFormField(
                context: context,
                  title: LocaleKeys.writeMedicalHistory.tr(),
                  hintText: LocaleKeys.writeMedicalHistory.tr(),
                  controller: textController,
                  prefix: Ic.baseline_format_color_text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.thisFieldMustBeFilled.tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  minLines: 3,
                  maxLines: 10)),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    textController.clear();
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    padding:  const EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: colorBlue4C,
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(32.0)),
                    ),
                    child: Text(
                      LocaleKeys.cancel.tr(),
                      style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: colorGrayF9),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      doctorCubit.createNewMedicalHistory(
                          doctorId: doctorCubit.doctorModel!.uId,
                          date: getDate(),
                          body: textController.text,
                          doctorName: doctorCubit.doctorModel!.name,
                          doctorImg: doctorCubit.doctorModel!.profileImg);
                  doctorCubit.getMedicalHistoryModel(uId: DoctorCubit.get(context).patientModel!.uId);
                    }
                  },
                  child: Container(
                    padding:
                    const EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: colorBlueC0,
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(32.0)),
                    ),
                    child: Text(
                      LocaleKeys.add.tr(),
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: colorGrayF9,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
