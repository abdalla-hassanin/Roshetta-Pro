import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/pharmacy/domain/entities/pharmacy_entity.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_data_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_profile_top_bar.dart';

class PharmacyProfileScreen extends StatelessWidget {
  final PharmacyEntity pharmacyEntity;

  const PharmacyProfileScreen(this.pharmacyEntity, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model1 = [
      {
        'title': context.l10n.email,
        'icon': Dashicons.email_alt,
        'value': pharmacyEntity.email
      },
      {
        'title': context.l10n.numberPhone,
        'icon': Ic.baseline_phone,
        'value': pharmacyEntity.mobilePhone
      },
      {
        'title': context.l10n.address,
        'icon': Ic.baseline_location_on,
        'value': pharmacyEntity.address
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
                  image: pharmacyEntity.imageUrl,
                  name: pharmacyEntity.name,
                  bio: pharmacyEntity.bio),
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
