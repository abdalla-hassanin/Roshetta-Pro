import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_data_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_top_bar.dart';

class PatientProfileScreen extends StatelessWidget {
  final PatientEntity patientEntity;

  const PatientProfileScreen(this.patientEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model1 = [
      {
        'title': context.l10n.email,
        'icon': Dashicons.email_alt,
        'value': patientEntity.email
      },
      {
        'title': context.l10n.numberPhone,
        'icon': Ic.baseline_phone,
        'value': patientEntity.mobileNumber
      },
      {
        'title': context.l10n.address,
        'icon': Ic.baseline_location_on,
        'value': patientEntity.address
      },
      {
        'title': context.l10n.age,
        'icon': Fa6Solid.calendar_days,
        'value': patientEntity.birthDay
      },
      {
        'title': context.l10n.gender,
        'icon': Ph.gender_intersex_fill,
        'value': (patientEntity.gender == 'male')
            ? context.l10n.male
            : context.l10n.female
      },
      {
        'title': context.l10n.blood,
        'icon': Fontisto.blood_drop,
        'value': patientEntity.blood
      },
      {
        'title': context.l10n.height,
        'icon': Mdi.human_male_height_variant,
        'value': patientEntity.height.toString()
      },
      {
        'title': context.l10n.weight,
        'icon': Mdi.weight_kilogram,
        'value': patientEntity.weight.toString()
      },
    ];
    return Scaffold(
        appBar: CustomTopBar(title: context.l10n.myProfile),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              myProfileTopBar(
                  context: context,
                  image: patientEntity.imageUrl,
                  name: patientEntity.name,
                  bio: patientEntity.bio),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => myProfileDataCard(
                    title: model1[index]['title'],
                    icon: model1[index]['icon'],
                    value: model1[index]['value']),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: model1.length,
              ),
            ],
          ),
        )));
  }
}
