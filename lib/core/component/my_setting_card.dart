import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

mySettingCard(
    {required BuildContext context,
    required String title,
    required String icon,
    required String description,
    Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: colorGrayF9,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: colorBlueC0,
                child: Iconify(icon, color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: colorBlue4C,
                    ),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'SST_Arabic',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: colorGray94,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Iconify(Directionality.of(context) == TextDirection.rtl
                  ? Ic.twotone_arrow_back_ios_new
                  : Ic.twotone_arrow_forward_ios, color: colorBlueC0),
            ],
          ),
        ),
      ),
    ),
  );
}
