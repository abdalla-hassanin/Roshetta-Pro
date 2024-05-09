import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/patient/data/models/medical_history_model.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_medical_history_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_text_form_field.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';

class DoctorPatientMedicalHistoryScreen extends StatelessWidget {
  final String patientId;

  const DoctorPatientMedicalHistoryScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DoctorCubit>().getPatientMedicalHistory(patientId);
    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.medicalHistory),
        body:
            BlocConsumer<DoctorCubit, DoctorState>(listener: (context, state) {
          if (state is GetPatientMedicalHistoryError ||
              state is AddNewMedicalHistoryError) {
            String? errorMsg;
            if (state is GetPatientMedicalHistoryError) {
              errorMsg = state.error;
            } else if (state is AddNewMedicalHistoryError) {
              errorMsg = state.error;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMsg!),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddNewMedicalHistorySuccess) {
            context.read<DoctorCubit>().getPatientMedicalHistory(patientId);
          }
        }, builder: (context, state) {
          if (state is GetPatientMedicalHistorySuccess) {
            final medicalHistory = state.patientMedicalHistory;

            if (medicalHistory.isEmpty) {
              return Center(
                child: Lottie.asset('assets/animation/no-data-preview.json'),
              );
            }
            return SingleChildScrollView(
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CustomMedicalHistoryCard(
                        image: medicalHistory[index].doctorImg,
                        doctorName: medicalHistory[index].doctorName,
                        date: medicalHistory[index].date,
                        bodyText: medicalHistory[index].body,
                      ),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: medicalHistory.length),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        floatingActionButton: FloatingActionButton.extended(
          hoverElevation: 50,
          backgroundColor: colorBlue4C,
          onPressed: () {
            _addMedicalHistoryDialog(context, patientId);
          },
          label: Text(
            context.l10n.addMedicalHistory,
            style: TextStyle(
              fontFamily: 'SST_Arabic',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: colorGrayF9,
            ),
          ),
          icon: Iconify(Ic.baseline_add, color: colorBlueC0),
        ));
  }

  void _addMedicalHistoryDialog(context, patientId) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            backgroundColor: colorGrayF9,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: MedicalHistoryDialog(patientId));
      },
    );
  }
}

class MedicalHistoryDialog extends StatelessWidget {
  final String patientId;

  MedicalHistoryDialog(this.patientId, {super.key});

  final TextEditingController medicalHistoryController =
      TextEditingController();

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
              child: CustomTextFormField(
                  title: context.l10n.writeMedicalHistory,
                  hintText: context.l10n.writeMedicalHistory,
                  controller: medicalHistoryController,
                  prefix: Ic.baseline_format_color_text,
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
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(
                        top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: colorBlue4C,
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(32.0)),
                    ),
                    child: Text(
                      context.l10n.cancel,
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
                      context.read<DoctorCubit>().addNewMedicalHistory(
                          patientId,
                          MedicalHistoryModel(
                            doctorId: 'doctorId',
                            date: getDate(),
                            body: medicalHistoryController.text,
                            doctorName: 'doctorName',
                            doctorImg: 'doctorImg',
                            dateTime: Timestamp.now(),
                          ));
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.only(
                        top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: colorBlueC0,
                      borderRadius: const BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(32.0)),
                    ),
                    child: Text(
                      context.l10n.add,
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
