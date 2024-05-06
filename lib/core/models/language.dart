import 'package:flutter/material.dart';

enum Language {
  english(
    Locale('en'),
    "🇺🇸",
    'English',
  ),
  arabic(
    Locale('ar'),
    "🇸🇦",
    'اَلْعَرَبِيَّةُ',
  );

  /// Add another languages support here

  const Language(this.value, this.flag, this.text);

  final Locale value;
  final String flag;
  final String text;
}