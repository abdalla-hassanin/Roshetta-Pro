import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/radix_icons.dart';
import 'package:roshetta_pro/core/component/app_snackbar.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_dialog_warning.dart';
import 'package:roshetta_pro/core/component/my_setting_card.dart';
import 'package:roshetta_pro/core/cubit/main_cubit.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';
import 'package:url_launcher/url_launcher.dart';

class DrSettingsScreen extends StatelessWidget {
  const DrSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit mainCubit = MainCubit.get(context);
        List<Map<String, dynamic>> model1 = [
          {
            'title': LocaleKeys.personalInfo.tr(),
            'icon': Ic.baseline_person,
            'description': LocaleKeys.personalInfo.tr(),
            'onTap': () => showToast(LocaleKeys.soon.tr(), '')
          },
          {
            'title': LocaleKeys.language.tr(),
            'icon': Ic.outline_language,
            'description': LocaleKeys.languageControl.tr(),
            'onTap': () {
              myDialogWarning(
                  context: context,
                  message: LocaleKeys.changeLanguage.tr(),
                  onYesTap: () async {
                    pop(context);
                    await mainCubit.changeLocalLanguage(context);
                  });
            }
          },
          {
            'title': LocaleKeys.darkMode.tr(),
            'icon': Ic.baseline_light_mode,
            'description': LocaleKeys.lightingControl.tr(),
            'onTap': () => showToast(LocaleKeys.soon.tr(), '')
          },
          {
            'title': LocaleKeys.notifications.tr(),
            'icon': Ic.outline_notifications_none,
            'description': LocaleKeys.notificationsControl.tr(),
            'onTap': () => showToast(LocaleKeys.soon.tr(), '')
          },
          {
            'title': LocaleKeys.aboutUs.tr(),
            'icon': Ion.information,
            'description': LocaleKeys.infoAboutUs.tr(),
            'onTap': () {
              launch("https://www.linkedin.com/in/abdalla-hassanin-646933221/");
            }
          },
          {
            'title': LocaleKeys.signOut.tr(),
            'icon': RadixIcons.exit,
            'description': LocaleKeys.signOut.tr(),
            'onTap': () {
              myDialogWarning(
                  context: context,
                  message: LocaleKeys.signOutFromAccount.tr(),
                  onYesTap: () => mainCubit.signOut(context));
            }
          },
        ];
        return Scaffold(
          appBar: myAppTopBar(
              context: context,
              title: LocaleKeys.settings.tr()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => mySettingCard(
                      title: model1[index]['title'],
                      icon: model1[index]['icon'],
                      description: model1[index]['description'],
                      onTap: model1[index]['onTap'], context: context
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
