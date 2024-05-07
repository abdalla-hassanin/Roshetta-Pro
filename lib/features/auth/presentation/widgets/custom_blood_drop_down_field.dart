import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fontisto.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/auth/presentation/manager/auth_cubit.dart';

class CustomBloodDropDownField extends StatelessWidget {
  const CustomBloodDropDownField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: Directionality.of(context) == material.TextDirection.rtl
            ? material.TextDirection.rtl
            : material.TextDirection.ltr,
        children: [
          Text(
            context.l10n.blood,
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
                  return context.l10n.thisFieldMustBeFilled;
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
                hintText: context.l10n.blood,
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
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 34, minHeight: 0),
                prefixIcon: Iconify(
                  Fontisto.blood_drop,
                  color: colorBlueC0,
                ),
              ),
              onChanged: (value) {
                context.read<AuthCubit>().patientChangeBloodValue(value);
              },
              icon: Iconify(
                Ic.twotone_keyboard_arrow_down,
                color: colorBlueC0,
              ),
              items:
                  ['A+', 'A-', 'B-', 'B+', 'O-', 'O+', 'AB-', 'AB+'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e,
                      style: TextStyle(
                        fontFamily: 'SST_Arabic',
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: colorBlue4C,
                      )),
                );
              }).toList(),
            ),
          )
        ]);
  }
}
