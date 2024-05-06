import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0x00212121),
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Color(0x00212121),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    // primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0x00181818),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsetsDirectional.only(top: 5, start: 30),
      hintStyle: const TextStyle(color: Colors.white),
    ),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0x00202a44),
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed),
    iconTheme: const IconThemeData(color: Colors.white),
    primaryIconTheme: const IconThemeData(color: Colors.white),
  );
}
