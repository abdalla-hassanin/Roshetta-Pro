import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

myDrugCard({
  required String drugName,
  required String drugQty,
  required String drugType,
  required String durationUse,
  required String timeUse,
  required String note,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colorGrayF9,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/drug.png', height: 24),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  drugName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: colorBlue4C,
                  ),
                ),
                const Spacer(),
                Text(
                  '$drugQty $drugType',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: colorGray94,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${LocaleKeys.durationUse.tr()} : ',
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorGray94,
                  ),
                ),
                Text(
                  '$durationUse ${LocaleKeys.days.tr()}',
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: colorBlue4C,
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LocaleKeys.timeUse.tr()} : ',
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorGray94,
                  ),
                ),
                Expanded(
                  child: Text(
                    timeUse,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: colorBlue4C,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${LocaleKeys.notes.tr()} : ',
                  style: TextStyle(
                    fontFamily: 'SST_Arabic',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: colorGray94,
                  ),
                ),
                Expanded(
                  child: Text(
                    note,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: colorBlue4C,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}