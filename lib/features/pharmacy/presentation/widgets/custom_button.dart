import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.all(6),
      color: colorBlueC0,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(color: Colors.transparent, width: 0),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'SST_Arabic',
          fontWeight: FontWeight.w700,
          color: colorGrayF9,
          fontSize: 18,
        ),
      ),
    );
  }
}
