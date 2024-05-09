import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomDrugCard extends StatelessWidget {
  final String drugName;
  final String drugQty;
  final String drugType;
  final String durationUse;
  final String timeUse;
  final String note;

  const CustomDrugCard({
    super.key,
    required this.drugName,
    required this.drugQty,
    required this.drugType,
    required this.durationUse,
    required this.timeUse,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
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
                    '${context.l10n.durationUse} : ',
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: colorGray94,
                    ),
                  ),
                  Text(
                    '$durationUse ${context.l10n.days}',
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
                    '${context.l10n.timeUse} : ',
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
                    '${context.l10n.notes} : ',
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
}
