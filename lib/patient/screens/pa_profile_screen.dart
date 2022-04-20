import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_profile_data_card.dart';
import 'package:roshetta_pro/core/component/my_profile_top_bar.dart';
import 'package:roshetta_pro/core/models/patient_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

class PaProfileScreen extends StatelessWidget {
  PatientModel patientModel;

  PaProfileScreen({Key? key, required this.patientModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model1 = [
      {
        'title': LocaleKeys.email.tr(),
        'icon': Dashicons.email_alt,
        'value': patientModel.email
      },
      {
        'title': LocaleKeys.numberPhone.tr(),
        'icon': Ic.baseline_phone,
        'value': patientModel.mobilePhone
      },
      {
        'title': LocaleKeys.address.tr(),
        'icon': Ic.baseline_location_on,
        'value': patientModel.address
      },
      {
        'title': LocaleKeys.age.tr(),
        'icon': Fa6Solid.calendar_days,
        'value': patientModel.birthDay
      },
      {
        'title': LocaleKeys.gender.tr(),
        'icon': Ph.gender_intersex_fill,
        'value': (patientModel.gender == Gender.male.name)
            ? LocaleKeys.male.tr()
            : LocaleKeys.female.tr()
      },
      {
        'title': LocaleKeys.blood.tr(),
        'icon': Fontisto.blood_drop,
        'value': patientModel.blood
      },
      {
        'title': LocaleKeys.height.tr(),
        'icon': Mdi.human_male_height_variant,
        'value': patientModel.height.toString()
      },
      {
        'title': LocaleKeys.weight.tr(),
        'icon': Mdi.weight_kilogram,
        'value': patientModel.weight.toString()
      },
    ];
    return Scaffold(
        appBar: myAppTopBar(context: context, title: LocaleKeys.myProfile.tr()),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              myProfileTopBar(
                  context: context,
                  image: patientModel.profileImg,
                  name: patientModel.name,
                  bio: patientModel.bio),
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
