import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_profile_data_card.dart';
import 'package:roshetta_pro/core/component/my_profile_top_bar.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

class DrProfileScreen extends StatelessWidget {
  const DrProfileScreen({Key? key, required this.doctorModel})
      : super(key: key);
  final DoctorModel doctorModel;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model = [
      {
        'title': LocaleKeys.email.tr(),
        'icon': Dashicons.email_alt,
        'value': doctorModel.email
      },
      {
        'title': LocaleKeys.numberPhone.tr(),
        'icon': Ic.baseline_phone,
        'value': doctorModel.mobilePhone
      },
      {
        'title': LocaleKeys.address.tr(),
        'icon': Ic.baseline_location_on,
        'value': doctorModel.address
      },
      {
        'title': LocaleKeys.medicalSpecialty.tr(),
        'icon': Ic.outline_folder_special,
        'value':Directionality.of(context) == material.TextDirection.rtl
            ? doctorModel.specialization['specialityAr']:doctorModel.specialization['specialityEn']
      },
      {
        'title': LocaleKeys.hospitalName.tr(),
        'icon': Uil.hospital_square_sign,
        'value': doctorModel.hospitalName
      },
      {
        'title': LocaleKeys.clinicName.tr(),
        'icon': Healthicons.ambulatory_clinic_outline,
        'value': doctorModel.clinicName
      },
    ];
    return Scaffold(
        appBar: myAppTopBar(
            context: context,
            title: LocaleKeys.doctorProfile.tr()),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              myProfileTopBar(
                  context: context,
                  image: doctorModel.profileImg,
                  name: doctorModel.name,
                  bio: doctorModel.bio),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => myProfileDataCard(
                    title: model[index]['title'],
                    icon: model[index]['icon'],
                    value: model[index]['value']),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: model.length,
              ),
            ],
          ),
        )));
  }
}
