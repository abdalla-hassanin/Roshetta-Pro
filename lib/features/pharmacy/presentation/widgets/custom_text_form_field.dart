import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:roshetta_pro/core/utils/constants.dart';


class CustomTextFormField extends StatelessWidget {
 final String title;
 final String hintText;
 final TextEditingController controller;
 final String prefix;
 final String? Function(String?)? validator;
 final TextInputType? keyboardType;
 final int? minLines;
 final int? maxLines ;
 final bool? isPassword;
 final String? suffix;
 final VoidCallback? suffixPressed;

  const CustomTextFormField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      required this.prefix,
      this.validator,
      this.keyboardType,
      this.minLines,
      this.maxLines,
      this.isPassword,
      this.suffix,
      this.suffixPressed});

  @override
  Widget build(BuildContext context) {
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
              obscureText: isPassword ?? false,
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.text,
              validator: validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return context.l10n.thisFieldMustBeFilled;
                    }
                    return null;
                  },
              minLines: minLines??1,
              maxLines: maxLines??1,
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
                    prefix,
                    color: colorBlueC0,
                  ),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 34, minHeight: 0),
                  suffixIcon: suffix != null
                      ? InkWell(
                          onTap: suffixPressed,
                          child: Iconify(
                            suffix!,
                            color: colorBlueC0,
                          ),
                        )
                      : null),
            ),
          )
        ]);
  }
}
