import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material ;
import 'package:roshetta_pro/auth/cubit/auth_cubit.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

myRadioGender(
    {
    required BuildContext context,
}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: Directionality.of(context) == material.TextDirection.rtl
          ? material.TextDirection.rtl
          : material.TextDirection.ltr,
      children: [
        Text(
          LocaleKeys.gender.tr(),
          style: TextStyle(
            fontFamily: 'SST_Arabic',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: colorBlue4C,
          ),
        ),
        Directionality(
            textDirection: Directionality.of(context) == material.TextDirection.rtl
                ? material.TextDirection.rtl
                : material.TextDirection.ltr,
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                    activeColor:colorBlueC0,
                      groupValue: AuthCubit.get(context).genderValue,
                      value: Gender.male.name,
                      onChanged: (value) {
                        AuthCubit.get(context).changeGenderValue(value);
                      },
                    ),
                    Text(
                      LocaleKeys.male.tr(),
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: colorBlue4C,
                      ),
                    ),
                  ],
                )),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          activeColor:colorBlueC0,
                          groupValue: AuthCubit.get(context).genderValue,
                          value:Gender.female.name,
                          onChanged: (value) {
                            AuthCubit.get(context).changeGenderValue(value);
                          },
                        ),
                        Text(
                          LocaleKeys.female.tr(),
                          style: TextStyle(
                            fontFamily: 'SST_Arabic',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: colorBlue4C,
                          ),
                        ),
                      ],
                    )),
              ],
            ))
      ]);
}
