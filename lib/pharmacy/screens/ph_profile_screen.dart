import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/dashicons.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_profile_data_card.dart';
import 'package:roshetta_pro/core/component/my_profile_top_bar.dart';
import 'package:roshetta_pro/core/models/pharmacy_model.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_cubit.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_state.dart';

class PhProfileScreen extends StatelessWidget {
  const PhProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit, PharmacyState>(
      listener: (context, state) {},
      builder: (context, state) {
        PharmacyCubit pharmacyCubit = PharmacyCubit.get(context);
        PharmacyModel? pharmacyModel = pharmacyCubit.pharmacyModel;

        List<Map<String, dynamic>> model1 = [
          {
            'title': LocaleKeys.email.tr(),
            'icon': Dashicons.email_alt,
            'value': pharmacyModel!.email
          },
          {
            'title': LocaleKeys.numberPhone.tr(),
            'icon': Ic.baseline_phone,
            'value': pharmacyModel.mobilePhone
          },
          {
            'title': LocaleKeys.address.tr(),
            'icon': Ic.baseline_location_on,
            'value': pharmacyModel.address
          },
        ];
        return Scaffold(
            appBar: myAppTopBar(
                context: context,
                title: LocaleKeys.myProfile.tr()),
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  myProfileTopBar(
                      context: context,
                      image: pharmacyModel.profileImg,
                      name: pharmacyModel.name,
                      bio: pharmacyModel.bio),
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
      },
    );
  }
}
