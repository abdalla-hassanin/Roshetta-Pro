import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';

myDialogWarning(
    {required BuildContext context,
    required String message,
    required VoidCallback onYesTap}) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: colorGrayF9,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: colorBlue4C,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pop(context, false),
                        child: Container(
                          padding:
                              const EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: colorBlue4C,
                            borderRadius: const BorderRadiusDirectional.only(
                                bottomStart: Radius.circular(32.0)),
                          ),
                          child: Text(
                            LocaleKeys.no.tr(),
                            style: TextStyle(
                                fontFamily: 'SST_Arabic',
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: colorGrayF9),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: onYesTap,
                        child: Container(
                          padding:
                              const EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: colorBlueC0,
                            borderRadius: const BorderRadiusDirectional.only(
                              bottomEnd: Radius.circular(32.0)),
                          ),
                          child: Text(
                            LocaleKeys.yes.tr(),
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: colorGrayF9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ));
}
