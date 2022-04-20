import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/auth/screens/login_screen.dart';
import 'package:roshetta_pro/core/cubit/main_state.dart';
import 'package:roshetta_pro/core/utils/cache_helper.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(context) => BlocProvider.of(context);


  Future changeLocalLanguage(BuildContext context) async {
    await context.setLocale(Directionality.of(context) == TextDirection.rtl
        ? const Locale('en')
        : const Locale('ar'));
    emit(ChangeLocalLanguageState());
  }

  bool isDark = false;
  String? darkModeRadio = 'Off';
  Color borderColor = Colors.grey.shade300;
  Color? textFieldColor = Colors.grey[300];
  Color? myMessageColor = Colors.blueAccent;
  Color? messageColor = Colors.grey[300];
  Color? unreadMessage = Colors.grey[300];
  Color textColor = Colors.black;
  Color backgroundColor = Colors.white;
  IconData? icon = Icons.brightness_4_outlined;

  void changeMode({fromCache}) {
    if (fromCache == null) {
      isDark = !isDark;
      //emit(ChangeModeState());
    } else {
      isDark = fromCache;
      //emit(ChangeModeState());
    }
    CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
      if (isDark) {
        appMode = ThemeMode.dark;
        darkModeRadio = 'On';
        icon = Icons.brightness_7;
        textColor = Colors.white;
        backgroundColor = const Color(0x00212121).withOpacity(0.8);
        textFieldColor = Colors.grey[900];
        unreadMessage = Colors.grey[800];
        borderColor = Colors.grey.shade900;
        messageColor = Colors.grey[600];
        myMessageColor = Colors.blueAccent;
        emit(ChangeModeState());
      } else {
        appMode = ThemeMode.light;
        darkModeRadio = 'Off';
        icon = Icons.brightness_4_outlined;
        backgroundColor = Colors.white;
        textColor = Colors.black;
        textFieldColor = Colors.grey[300];
        borderColor = Colors.grey.shade300;
        messageColor = Colors.grey[300];
        unreadMessage = Colors.grey[300];
        myMessageColor = Colors.blueAccent;
        emit(ChangeModeState());
      }
      emit(ChangeModeState());
    });
  }

  signOut(context) {
    emit(SignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) async {
      CacheHelper.removeData('uId');
      CacheHelper.removeData('userType');
      constUId = null;
      constUserType = null;
      if (kDebugMode) {
        print('Sign Out---------------------');
        print('I\'m $constUserType and my Id:$constUId');
      }

      navigateAndKill(context, LoginScreen());
      emit(SignOutSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SignOutErrorState());
    });
  }
}
