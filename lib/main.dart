import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/cubit/main_cubit.dart';
import 'package:roshetta_pro/core/cubit/main_state.dart';
import 'package:roshetta_pro/core/screens/splash_screen.dart';
import 'package:roshetta_pro/core/utils/themes.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/doctor_layout.dart';
import 'package:roshetta_pro/patient/cubit/patient_cubit.dart';
import 'package:roshetta_pro/patient/patient_layout.dart';
import 'package:roshetta_pro/pharmacy/cubit/pharmacy_cubit.dart';
import 'package:roshetta_pro/pharmacy/pharmacy_layout.dart';

import 'auth/screens/login_screen.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/cache_helper.dart';
import 'core/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC3VMNDIJAY1Kk2vdDXo8eROUTJJbNi63k",
          appId: "1:216931135050:web:4b3e9c49ae93c667f740b3",
          messagingSenderId: "216931135050",
          projectId: "e-prescription-132c1",
          storageBucket: 'e-prescription-132c1.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget? widget;

  bool? isDark = CacheHelper.getData('isDark');
  constUId = CacheHelper.getData(CacheName.uId.name);
  constUserType = CacheHelper.getData(CacheName.userType.name);

  if (constUId !=null  && constUserType !=null) {
      debugPrint('I\'m $constUserType and my Id:$constUId');
    if (constUserType == UserType.patient.name) {
      widget =  PatientLayout();
    } else if (constUserType == UserType.doctor.name) {
      widget =  DoctorLayout();
    } else if (constUserType == UserType.pharmacy.name) {
      widget =  PharmacyLayout();
    }
  } else {
    debugPrint('I\'m $constUserType and my Id:$constUId');
    CacheHelper.removeData(CacheName.uId.name);
    CacheHelper.removeData(CacheName.userType.name);
    constUId=null;
    constUserType=null;
    widget =  LoginScreen();
  }

  runApp(EasyLocalization(
    supportedLocales:  const [Locale('en'), Locale('ar')],
    path: 'assets/translations',
    // <-- change the path of the translation files
    fallbackLocale: const Locale('en'),
    child: MyApp(
      isDark: isDark,
      startWidget: widget!,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
   final Widget startWidget;

   const MyApp({Key? key, this.isDark, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit()..changeMode(fromCache: isDark),
        ),
        BlocProvider(
          create: (context) => PatientCubit()..getPatientData(uId: constUId!),
        ),
        BlocProvider(
            create: (context) => PharmacyCubit()..getPharmacyModel(uId: constUId!)
            ),
        BlocProvider(
          create: (context) => DoctorCubit()..getDoctorModel(uId: constUId!)
        ),
      ],
      child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                home: AnimatedSplashScreen(
                  splash: const SplashScreen(),
                  splashIconSize:double.infinity,
                  nextScreen: startWidget,
                  animationDuration: const Duration(milliseconds: 2500),
                ),
                theme: lightMode(),
                // darkTheme: darkMode(),
                // themeMode: appMode
            );
          }),
    );
  }
}
