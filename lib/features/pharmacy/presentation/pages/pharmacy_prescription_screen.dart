import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/prescription_entity.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_alert_dialog.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_drug_card.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';

class PharmacyPrescriptionScreen extends StatelessWidget {
  final PrescriptionEntity prescription;

  const PharmacyPrescriptionScreen(this.prescription, {super.key});

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
                message: context.l10n.exitPatientProfile,
                onYesTap: () {
                  Navigator.of(context).pop(true);
                }) ?? false;
        if (shouldPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
          appBar: CustomTopBar(
              title:
                  '${context.l10n.prescriptionId}: ${prescription.prescriptionId}'),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //ToDo: show doctor profile
                // CustomInfoCard(
                //
                //     image: doctorModel.profileImg,
                //     name: doctorModel.name,
                //     email: doctorModel.email,
                //     mobilePhone: doctorModel.mobilePhone,
                //     navigateToWidget:
                //     DrProfileScreen(doctorModel: doctorModel)),
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
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CustomDrugCard(
                      drugName: prescription.drugModel[index].drugName,
                      drugQty: prescription.drugModel[index].drugQty,
                      drugType: prescription.drugModel[index].drugType,
                      durationUse: prescription.drugModel[index].durationOfUse,
                      timeUse: prescription.drugModel[index].timeOfUse,
                      note: prescription.drugModel[index].note),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemCount: prescription.drugModel.length,
                ),
              ],
            ),
          )),
    );
  }

}
