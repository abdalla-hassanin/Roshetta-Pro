import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:numberpicker/numberpicker.dart';

class CustomNumberPicker extends StatelessWidget {
  final String title;
  final int minValue;
  final int maxValue;
  final Function(int) onChanged;
  final int value;

  const CustomNumberPicker({super.key,
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            const Spacer(),
            NumberPicker(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorGray94),
              ),
              itemCount: 3,
              itemWidth: 50,
              axis: Axis.horizontal,
              textStyle: TextStyle(
                fontFamily: 'SST_Arabic',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: colorBlue4C,
              ),
              selectedTextStyle: TextStyle(
                fontFamily: 'SST_Arabic',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: colorBlueC0,
              ),
              value: value,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: onChanged,
            ),
            const Spacer(),
          ]),
    );
  }
}
