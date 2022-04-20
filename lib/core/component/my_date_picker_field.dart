import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:iconify_flutter/icons/fluent.dart';

myDatePickerField({
  required BuildContext context,
  required String title,
  required String hintText,
  required TextEditingController controller,
}) {
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
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return LocaleKeys.thisFieldMustBeFilled.tr();
              }
              return null;
            },
            onTap: () async {
              // Below line stops keyboard from appearing
              FocusScope.of(context).requestFocus(FocusNode());
              // Show Date Picker Here
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.parse('1900-01-01'),
                lastDate: DateTime.now(),
              ).then((value) {
                controller.text = DateFormat.yMMMd().format(value!);
              });
            },
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 34, minHeight: 0),
              prefixIcon: Iconify(
                Fluent.calendar_today_16_regular,
                color: colorBlueC0,
              ),
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 34, minHeight: 0),
              suffixIcon: Iconify(
                Ic.baseline_date_range,
                color: colorBlueC0,
              ),
            ),
          ),
        )
      ]);
}
