import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

myTextFormField(
    {required String title,
    required String hintText,
    required TextEditingController controller,
    required String prefix,
    required String? Function(String?) validator,
    required TextInputType? keyboardType,
    required BuildContext context,
    int? minLines,
    int? maxLines = 1,
      bool isPassword=false,
      String? suffix,
      VoidCallback? suffixPressed
    }) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: Directionality.of(context) == TextDirection.rtl
          ? TextDirection.rtl
          : TextDirection.ltr,
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
          textDirection: Directionality.of(context) == TextDirection.rtl
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: TextFormField(
            obscureText: isPassword,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
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
              suffixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 0) ,
              suffixIcon: suffix != null?
              InkWell(
                onTap: suffixPressed,
                child: Iconify(
                  suffix,
                  color: colorBlueC0,
                ),
              )
                  :null
            ),
          ),
        )
      ]);
}
