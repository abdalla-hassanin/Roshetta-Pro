import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

myAppTopBar({
  required BuildContext context,
  required String title,
  VoidCallback? leadingOnTap,
  String? leadingIcon,
}) {
  return AppBar(
    elevation: 0,
    // leadingWidth: kToolbarHeight * 0.55,
    leading: IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: leadingOnTap ?? () => Navigator.maybePop(context),
      icon: Iconify(
          leadingIcon ??
              (Directionality.of(context) == TextDirection.rtl
                  ? Ic.twotone_arrow_forward_ios
                  : Ic.twotone_arrow_back_ios_new),
          color: colorBlueC0),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'SST_Arabic',
        fontWeight: FontWeight.w900,
        wordSpacing: 1.5,
        letterSpacing: 1.7,
        fontSize: 24,
        color: colorBlue4C,
      ),
    ),
  );
}

myAppTopBarWithAction({
  required BuildContext context,
  required String title,
  VoidCallback? leadingOnTap,
  String? leadingIcon,
  required String actionIcon,
  VoidCallback? actionOnTap,
}) {
  return AppBar(
    elevation: 0,
    // leadingWidth: kToolbarHeight * 0.55,
    leading: IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: leadingOnTap ?? () => Navigator.maybePop(context),
      icon: Iconify(
          leadingIcon ??
              (Directionality.of(context) == TextDirection.rtl
                  ? Ic.twotone_arrow_forward_ios
                  : Ic.twotone_arrow_back_ios_new),
          color: colorBlueC0),
    ),
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'SST_Arabic',
        fontWeight: FontWeight.w900,
        wordSpacing: 1.5,
        letterSpacing: 1.7,
        fontSize: 24,
        color: colorBlue4C,
      ),
    ),
    actions: [
      IconButton(
        padding: const EdgeInsets.all(0),
        onPressed: actionOnTap,
        icon: Iconify(actionIcon, color: colorBlueC0),
      ),
    ],
  );
}
