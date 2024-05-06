import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:roshetta_pro/core/core_cubit/core_cubit.dart';
import 'package:roshetta_pro/core/internet_cubit/internet_cubit.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/theme/dark_theme.dart';
import 'package:roshetta_pro/core/theme/light_theme.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/doctor_auth/presentation/manager/doctor_auth_cubit.dart';
import 'package:roshetta_pro/features/patient/presentation/manager/patient_cubit.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/manager/patient_auth_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/manager/pharmacy_cubit.dart';
import 'package:roshetta_pro/features/pharmacy_auth/presentation/manager/pharmacy_auth_cubit.dart';
import 'package:roshetta_pro/firebase_options.dart';

import 'core/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupDI();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCubit()..checkConnection()),
        BlocProvider(create: (context) => CoreCubit()..getCoreSettings()),
        BlocProvider(
          create: (context) => PharmacyCubit(),
        ),
        BlocProvider(
          create: (context) => PharmacyAuthCubit(),
        ),
        BlocProvider(
          create: (context) => DoctorAuthCubit(),
        ),
        BlocProvider(create: (context) => DoctorCubit()),
        BlocProvider(
          create: (context) => PatientAuthCubit(),
        ),
        BlocProvider(
          create: (context) => PatientCubit(),
        ),
      ],
      child: BlocBuilder<CoreCubit, CoreState>(
        builder: (context, coreState) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: coreState.themeMode,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          localizationsDelegates:
          AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: coreState.language.value,
          onGenerateRoute: AppRoutes.onGenerate,
          initialRoute: Routes.coreScreen,
          );
        },
      ),
    );
  }
}
