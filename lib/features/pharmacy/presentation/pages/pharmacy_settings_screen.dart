import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:roshetta_pro/core/core_cubit/core_cubit.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_setting_card.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/my_dialog_warning.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacySettingsScreen extends StatelessWidget {
  const PharmacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> model1 = [
      {
        'title': context.l10n.personalInfo,
        'icon': Ic.baseline_person,
        'description': context.l10n.personalInfo,
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.soon),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      {
        'title': context.l10n.language,
        'icon': Ic.outline_language,
        'description': context.l10n.languageControl,
        'onTap': () {
          myDialogWarning(
              context: context,
              message: context.l10n.changeLanguage,
              onYesTap: () async {
                context.read<CoreCubit>().changeLanguageCoreSettings();
                Navigator.pop(context);
              });
        }
      },
      {
        'title': context.l10n.darkMode,
        'icon': Ic.baseline_light_mode,
        'description': context.l10n.lightingControl,
        'onTap': () {
          myDialogWarning(
              context: context,
              message: context.l10n.lightingControl,
              onYesTap: () async {
                context.read<CoreCubit>().changeThemeCoreSettings();
                Navigator.pop(context);
              });
        }
      },
      {
        'title': context.l10n.notifications,
        'icon': Ic.outline_notifications_none,
        'description': context.l10n.notificationsControl,
        'onTap': () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.soon),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      {
        'title': context.l10n.aboutUs,
        'icon': Ion.information,
        'description': context.l10n.infoAboutUs,
        'onTap': () {
          launchUrl(Uri(
              path: "https://www.linkedin.com/in/abdalla-hassanin-646933221/"));
        }
      },
      {
        'title': context.l10n.signOut,
        'icon': RadixIcons.exit,
        'description': context.l10n.signOut,
        'onTap': () {
          myDialogWarning(
              context: context,
              message: context.l10n.signOutFromAccount,
              onYesTap: () {
                context.read<AuthCubit>().signOut();
              });
        }
      },
    ];
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is SignOutSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.signInScreen, (route) => false);
          });
        } else if (state is SignOutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }

        return Scaffold(
          appBar: CustomTopBar(title: context.l10n.settings),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => CustomSettingCard(
                    title: model1[index]['title'],
                    icon: model1[index]['icon'],
                    description: model1[index]['description'],
                    onTap: model1[index]['onTap'],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: model1.length,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
