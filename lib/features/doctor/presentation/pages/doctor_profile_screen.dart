import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/auth/domain/entities/doctor_entity.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_data_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_top_bar.dart';

class DoctorProfileScreen extends StatelessWidget {
  final DoctorEntity doctorEntity;

  const DoctorProfileScreen(this.doctorEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model1 = [
      {
        'title': context.l10n.email,
        'icon': Dashicons.email_alt,
        'value': doctorEntity.email
      },
      {
        'title': context.l10n.numberPhone,
        'icon': Ic.baseline_phone,
        'value': doctorEntity.mobilePhone
      },
      {
        'title': context.l10n.address,
        'icon': Ic.baseline_location_on,
        'value': doctorEntity.address
      },
      {
        'title': context.l10n.medicalSpecialty,
        'icon': Ic.outline_folder_special,
        'value': Directionality.of(context) == material.TextDirection.rtl
            ? doctorEntity.specialization['specialityAr']
            : doctorEntity.specialization['specialityEn']
      },
      {
        'title': context.l10n.hospitalName,
        'icon': Uil.hospital_square_sign,
        'value': doctorEntity.hospitalName
      },
      {
        'title': context.l10n.clinicName,
        'icon': Healthicons.ambulatory_clinic_outline,
        'value': doctorEntity.clinicName
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
                  image: doctorEntity.imageUrl,
                  name: doctorEntity.name,
                  bio: doctorEntity.bio),
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
