import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_drug_card.dart';
import 'package:roshetta_pro/core/component/my_info_top_bar.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/core/models/prescription_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/screens/dr_profile_screen.dart';

class PrescriptionScreen extends StatelessWidget {
  final PrescriptionModel prescriptionModel;
  final DoctorModel doctorModel;

  const PrescriptionScreen(
      {Key? key, required this.prescriptionModel, required this.doctorModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppTopBar(
            context: context,
            title: '${LocaleKeys.prescriptionId.tr()}: ${prescriptionModel.prescriptionId}'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myInfoTopBar(
                  context: context,
                  image: doctorModel.profileImg,
                  name: doctorModel.name,
                  email: doctorModel.email,
                  mobilePhone: doctorModel.mobilePhone,
                  navigateToWidget:
                  DrProfileScreen(doctorModel: doctorModel)),
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
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => myDrugCard(
                    drugName: prescriptionModel.drugModel[index].drugName,
                    drugQty: prescriptionModel.drugModel[index].drugQty,
                    drugType: prescriptionModel.drugModel[index].drugType,
                    durationUse:
                        prescriptionModel.drugModel[index].durationOfUse,
                    timeUse: prescriptionModel.drugModel[index].timeOfUse,
                    note: prescriptionModel.drugModel[index].note),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: prescriptionModel.drugModel.length,
              ),
            ],
          ),
        ));
  }
}
