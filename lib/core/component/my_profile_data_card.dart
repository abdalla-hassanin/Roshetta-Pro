import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

myProfileDataCard({
  required String title,
  required String icon,
  required String value,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        '$title: ',
        style: TextStyle(
          fontFamily: 'SST_Arabic',
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: colorBlue4C,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: colorGrayF9,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Row(
                  children: [
                    Iconify(icon, color: colorBlueC0),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: colorBlue4C,
                        ),
                      ),
                    )
                  ],
                ),
              )))
    ],
  );
}
