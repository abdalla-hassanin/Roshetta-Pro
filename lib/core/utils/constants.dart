import 'dart:math';

import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

Color defaultColor = Colors.blueAccent;
var colorGrayF9 = const Color(0xFFF9F9F9);
var colorGray94 = const Color(0xFF949494);
var colorBlueC0 = const Color(0xFF5371C0);
var colorBlue4C = const Color(0xFF2B394C);

// Future navigateTo(BuildContext context,Widget widget) async {
//   return await Navigator.push(context, MaterialPageRoute(builder: (context) => widget, ));
// }
//
// void navigateAndKill (context,widget) {
//   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
// }
//
// void pop (context) {
//   Navigator.pop(context);
// }
Widget imagePreview(String? image){
  return FullScreenWidget(
    child: Center(
      child: Image.network(
        "$image",
        fit: BoxFit.cover,
        width: double.infinity,
        alignment: AlignmentDirectional.topCenter,
      ),
    ),
  );
}
String getDate ()
{
  DateTime dateTime =  DateTime.now();
  String date =  DateFormat.yMMMd().format(dateTime);
  return date;
}

String getRandomId(){
  Random random = Random();
  int randomNumber = random.nextInt(10000);
  int dateTime =  DateTime.now().minute;
  return randomNumber.toString()+dateTime.toString();

}
extension BuildContextExt on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}