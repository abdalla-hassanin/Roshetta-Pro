import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class CustomTopBarWithAction extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback? leadingOnTap;
  final String? leadingIcon;
  final String actionIcon;
  final VoidCallback? actionOnTap;
  const CustomTopBarWithAction(
      {super.key,
      required this.title,
        this.leadingIcon,
        this.leadingOnTap,
        required this.actionIcon,
        this.actionOnTap
     });

  @override
  Widget build(BuildContext context) {
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
