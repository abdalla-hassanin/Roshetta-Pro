import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_dialog_warning.dart';
import 'package:roshetta_pro/core/component/my_drug_card.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/models/drug_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';

class NewPrescriptionScreen extends StatelessWidget {
  const NewPrescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        DoctorCubit doctorCubit = DoctorCubit.get(context);

        List<DrugModel> drugModels = doctorCubit.drugModels;

        return WillPopScope(
          onWillPop: () async {
            final shouldPop = await myDialogWarning(
                context: context,
                message: LocaleKeys.exitPrescription.tr(),
                onYesTap: () {
                  clearScreen(doctorCubit);
                  Navigator.pop(context, true);
                });
            return shouldPop ?? false;
          },
          child: Scaffold(
              appBar: myAppTopBarWithAction(
                  context: context,
                  title: LocaleKeys.newPrescription.tr(),
                  actionIcon: Dashicons.saved,
                  actionOnTap: () {
                    myDialogWarning(
                        context: context,
                        message: LocaleKeys.savePrescription.tr(),
                        onYesTap: () {
                          //TODO
                          if (doctorCubit.drugModels.isNotEmpty) {
                            doctorCubit.createNewPrescription(
                                doctorId: doctorCubit.doctorModel!.uId,
                                doctorName: doctorCubit.doctorModel!.name,
                                doctorImg: doctorCubit.doctorModel!.profileImg,
                                prescriptionId: getRandomId(),
                                doctorDate: getDate(),
                                drugModel: doctorCubit.drugModels);
                            doctorCubit.getPrescriptionModel(
                                uId:
                                    DoctorCubit.get(context).patientModel!.uId);

                            clearScreen(doctorCubit);
                            Navigator.pop(context, true);
                            Navigator.pop(context, true);
                          }
                        });
                  }),
              body: ifConditional(
                context: context,
                conditionBuilder: (context) => drugModels.isNotEmpty,
                fallbackBuilder: (context) => Center(
                  child: Text(LocaleKeys.noDrugsYet.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: colorBlue4C,
                      )),
                ),
                widgetBuilder: (context) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          LocaleKeys.drugs.tr(),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => myDrugCard(
                              drugName: drugModels[index].drugName,
                              drugQty: drugModels[index].drugQty,
                              drugType: drugModels[index].drugType,
                              durationUse: drugModels[index].durationOfUse,
                              timeUse: drugModels[index].timeOfUse,
                              note: drugModels[index].note),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                          itemCount: drugModels.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                hoverElevation: 50,
                backgroundColor: colorBlue4C,
                onPressed: () {
                  _addDrugDialog(context, doctorCubit);
                },
                label: Text(
                  LocaleKeys.addDrug.tr(),
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: colorGrayF9,
                  ),
                ),
                icon: Iconify(Ic.baseline_add, color: colorBlueC0),
              )),
        );
      },
    );
  }

  void _addDrugDialog(context, DoctorCubit doctorCubit) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: colorGrayF9,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          contentPadding: const EdgeInsets.all(12.0),
          content: AddDrugDialog(
            doctorCubit: doctorCubit,
          ),
        );
      },
    );
  }

  clearScreen(DoctorCubit cubit) {
    cubit.drugModels.clear();
  }
}

class AddDrugDialog extends StatelessWidget {
  DoctorCubit doctorCubit;

  AddDrugDialog({Key? key, required this.doctorCubit}) : super(key: key);
  TextEditingController drugNameController = TextEditingController();
  TextEditingController amountDrugController = TextEditingController();
  TextEditingController typeDrugNameController = TextEditingController();
  TextEditingController longOfUseController = TextEditingController();
  TextEditingController timeOfUseController = TextEditingController();
  TextEditingController notesController = TextEditingController();
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
              myTextFormField(
  context: context,                  title: LocaleKeys.drugName.tr(),
                  hintText: LocaleKeys.drugName.tr(),
                  controller: drugNameController,
                  prefix: Ic.sharp_medication_liquid,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.thisFieldMustBeFilled.tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text),
              Row(
                children: [
                  Expanded(
                    child: myTextFormField(
                        context: context,
                        title: LocaleKeys.drugAmount.tr(),
                        hintText: LocaleKeys.drugAmount.tr(),
                        controller: amountDrugController,
                        prefix: Ic.sharp_medication_liquid,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.thisFieldMustBeFilled.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: myTextFormField(
                        context: context,
                        title: LocaleKeys.drugType.tr(),
                        hintText: LocaleKeys.drugType.tr(),
                        controller: typeDrugNameController,
                        prefix: Ic.sharp_medication_liquid,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleKeys.thisFieldMustBeFilled.tr();
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text),
                  ),
                ],
              ),
              myTextFormField(
  context: context,                  title: LocaleKeys.howLong.tr(),
                  hintText: LocaleKeys.howLong.tr(),
                  controller: longOfUseController,
                  prefix: Ic.sharp_medication_liquid,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.thisFieldMustBeFilled.tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text),
              myTextFormField(
  context: context,                  title: LocaleKeys.timeOfUse.tr(),
                  hintText: LocaleKeys.timeOfUse.tr(),
                  controller: timeOfUseController,
                  prefix: Ic.sharp_medication_liquid,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.thisFieldMustBeFilled.tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text),
              myTextFormField(
  context: context,                  title: LocaleKeys.notes.tr(),
                  hintText: LocaleKeys.notes.tr(),
                  controller: notesController,
                  prefix: Ic.sharp_medication_liquid,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return LocaleKeys.thisFieldMustBeFilled.tr();
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 12,
              ),
              myButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      doctorCubit.addDrugModel(
                          drugName: drugNameController.text,
                          drugQty: amountDrugController.text,
                          drugType: typeDrugNameController.text,
                          durationOfUse: longOfUseController.text,
                          timeOfUse: timeOfUseController.text,
                          note: notesController.text);
                      pop(context);
                    }
                  },
                  text: LocaleKeys.save.tr())
            ]),
      ),
    );
  }
}
