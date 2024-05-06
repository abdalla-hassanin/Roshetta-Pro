import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core_state.dart';

enum SharedKeys { language, themeMode }

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreState(Language.english, ThemeMode.system));

  Future<void> getCoreSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? languagePref = prefs.getString(SharedKeys.language.name);
    final String? themePref = prefs.getString(SharedKeys.themeMode.name);

    if (languagePref != null && themePref != null) {
      Language language = Language.values.firstWhere(
        (item) => item.value.languageCode == languagePref,
        orElse: () => Language.english,
      );
      ThemeMode themeMode = (themePref == ThemeMode.light.name)
          ? ThemeMode.light
          : ThemeMode.dark;

      emit(CoreState(language, themeMode));
    } else {
      emit(CoreState(Language.english, ThemeMode.system));
    }
  }

  Future<void> setCoreSettings(
      {Language? language, ThemeMode? themeMode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Language languagePref = language ?? state.language;
    ThemeMode themePref = themeMode ?? state.themeMode;
    await prefs.setString(
        SharedKeys.language.name, languagePref.value.languageCode);
    await prefs.setString(SharedKeys.themeMode.name, themePref.name);

    emit(CoreState(languagePref, themePref));
  }

  Future<void> changeThemeCoreSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode themePref =
        (state.themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    Language languagePref = state.language;
    await prefs.setString(
        SharedKeys.language.name, languagePref.value.languageCode);
    await prefs.setString(SharedKeys.themeMode.name, themePref.name);
    emit(CoreState(languagePref, themePref));
  }

  Future<void> changeLanguageCoreSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode themePref = state.themeMode;
    Language languagePref = (state.language == Language.english)
        ? Language.arabic
        : Language.english;
    await prefs.setString(
        SharedKeys.language.name, languagePref.value.languageCode);
    await prefs.setString(SharedKeys.themeMode.name, themePref.name);
    emit(CoreState(languagePref, themePref));
  }
}
