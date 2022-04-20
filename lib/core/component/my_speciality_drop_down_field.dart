import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/auth/cubit/auth_cubit.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

mySpecialityDropDownField(
    {required String title,
    required String hintText,
    required BuildContext context,
    required List items,
    required AuthCubit authCubit}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: Directionality.of(context) == material.TextDirection.rtl
          ? material.TextDirection.rtl
          : material.TextDirection.ltr,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'SST_Arabic',
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: colorBlue4C,
          ),
        ),
        Directionality(
          textDirection:
              Directionality.of(context) == material.TextDirection.rtl
                  ? material.TextDirection.rtl
                  : material.TextDirection.ltr,
          child: DropdownButtonFormField(
            itemHeight: kMinInteractiveDimension * 1.25,
            validator: (value) {
              if (value == null) {
                return LocaleKeys.thisFieldMustBeFilled.tr();
              }
              return null;
            },
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: colorBlue4C,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              hintText: hintText,
              hintStyle: TextStyle(
                color: colorGray94,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorBlueC0, width: 2),
                borderRadius: BorderRadius.circular(25.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: colorGray94, width: 2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: colorGray94, width: 2)),
            ),
            onChanged: (value) {
              authCubit.changeSpecializationValue(value);
            },
            icon: Iconify(
              Ic.twotone_keyboard_arrow_down,
              color: colorBlueC0,
            ),
            items: items.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Row(
                  children: [
                    Image.asset(
                      e['image'],
                      fit: BoxFit.cover,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                        Directionality.of(context) == material.TextDirection.rtl
                            ? e['specialityAr']
                            : e['specialityEn'],
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: colorBlue4C,
                        )),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ]);
}
