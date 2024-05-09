import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/patient/data/models/drug_model.dart';
import 'package:roshetta_pro/features/patient/data/models/prescription_model.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_button.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_drug_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_text_form_field.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar_with_action.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_alert_dialog.dart';

class DoctorNewPrescriptionScreen extends StatelessWidget {
  final String patientId;

  const DoctorNewPrescriptionScreen(this.patientId, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await customAlertDialog(
                  context: context,
                  message: context.l10n.sureExit,
                  onYesTap: (){
                    Navigator.of(context).pop(true);
                    context.read<DoctorCubit>().drugs.clear();
                    context.read<DoctorCubit>().getPatientPrescriptions(patientId);
                  }) ??
              false;
          if (shouldPop) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
            appBar: CustomTopBarWithAction(
                title: context.l10n.newPrescription,
                actionIcon: Dashicons.saved,
                actionOnTap: () {
                  customAlertDialog(
                      context: context,
                      message: context.l10n.savePrescription,
                      onYesTap: () {
                        if (context.read<DoctorCubit>().drugs.isNotEmpty) {
                          //TODO : check doctor information
                          context.read<DoctorCubit>().addNewPrescription(
                              patientId,
                              PrescriptionModel(
                                doctorId: 'doctorId',
                                doctorName: 'doctorName',
                                doctorImg: 'doctorImg',
                                prescriptionId: getRandomId(),
                                doctorDate: getDate(),
                                drugModel: context.read<DoctorCubit>().drugs,
                                dateTime: Timestamp.now(),
                              ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please add drugs'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      });
                }),
            body: BlocConsumer<DoctorCubit, DoctorState>(
              listener: (context, state) {
                if (state is AddNewPrescriptionError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else if (state is AddNewPrescriptionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.state),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop(true);
                  context.read<DoctorCubit>().drugs.clear();
                  context
                      .read<DoctorCubit>()
                      .getPatientPrescriptions(patientId);
                }
              },
              builder: (context, state) {
                if (state is AddNewPrescriptionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DrugModel> drugs = context.read<DoctorCubit>().drugs;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          context.l10n.drugs,
                          style: TextStyle(
                            fontFamily: 'SST_Arabic',
                            fontWeight: FontWeight.w900,
                            wordSpacing: 1.5,
                            letterSpacing: 1.7,
                            fontSize: 24,
                            color: colorBlue4C,
                          ),
                        ),
                      ),
                      drugs.isEmpty
                          ? Center(
                              child: Text(context.l10n.noDrugsYet,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SST_Arabic',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20,
                                    color: colorBlue4C,
                                  )),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => CustomDrugCard(
                                    drugName: drugs[index].drugName,
                                    drugQty: drugs[index].drugQty,
                                    drugType: drugs[index].drugType,
                                    durationUse: drugs[index].durationOfUse,
                                    timeUse: drugs[index].timeOfUse,
                                    note: drugs[index].note),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 5,
                                ),
                                itemCount: drugs.length,
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
              hoverElevation: 50,
              backgroundColor: colorBlue4C,
              onPressed: () {
                _addDrugDialog(context);
              },
              label: Text(
                context.l10n.addDrug,
                style: TextStyle(
                  fontFamily: 'SST_Arabic',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: colorGrayF9,
                ),
              ),
              icon: Iconify(Ic.baseline_add, color: colorBlueC0),
            )));
  }



  void _addDrugDialog(context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: colorGrayF9,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          contentPadding: const EdgeInsets.all(12.0),
          content: AddDrugDialog(),
        );
      },
    );
  }
}

class AddDrugDialog extends StatelessWidget {
  AddDrugDialog({super.key});

  final TextEditingController drugNameController = TextEditingController();

  final TextEditingController amountDrugController = TextEditingController();

  final TextEditingController typeDrugNameController = TextEditingController();

  final TextEditingController longOfUseController = TextEditingController();

  final TextEditingController timeOfUseController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                title: context.l10n.drugName,
                hintText: context.l10n.drugName,
                controller: drugNameController,
                prefix: Ic.sharp_medication_liquid,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                        title: context.l10n.drugAmount,
                        hintText: context.l10n.drugAmount,
                        controller: amountDrugController,
                        prefix: Ic.sharp_medication_liquid,
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: CustomTextFormField(
                        title: context.l10n.drugType,
                        hintText: context.l10n.drugType,
                        controller: typeDrugNameController,
                        prefix: Ic.sharp_medication_liquid,
                        keyboardType: TextInputType.text),
                  ),
                ],
              ),
              CustomTextFormField(
                title: context.l10n.howLong,
                hintText: context.l10n.howLong,
                controller: longOfUseController,
                prefix: Ic.sharp_medication_liquid,
              ),
              CustomTextFormField(
                title: context.l10n.timeOfUse,
                hintText: context.l10n.timeOfUse,
                controller: timeOfUseController,
                prefix: Ic.sharp_medication_liquid,
              ),
              CustomTextFormField(
                title: context.l10n.notes,
                hintText: context.l10n.notes,
                controller: notesController,
                prefix: Ic.sharp_medication_liquid,
              ),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<DoctorCubit>().addDrugEntityToList(DrugModel(
                          drugName: drugNameController.text,
                          drugQty: amountDrugController.text,
                          drugType: typeDrugNameController.text,
                          durationOfUse: longOfUseController.text,
                          timeOfUse: timeOfUseController.text,
                          note: notesController.text));

                      Navigator.of(context).pop();
                    }
                  },
                  text: context.l10n.save)
            ]),
      ),
    );
  }
}
