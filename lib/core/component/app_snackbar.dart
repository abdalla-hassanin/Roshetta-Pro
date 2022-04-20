import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

void showToast(msg, messageType) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: (messageType == 'Success')
          ? (Colors.green[200])
          : (messageType == 'Error')
              ? (Colors.red[200])
              : (colorBlueC0),
      textColor: colorGrayF9,
      fontSize: 20.0);
}
