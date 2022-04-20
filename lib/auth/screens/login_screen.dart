import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/auth/cubit/auth_cubit.dart';
import 'package:roshetta_pro/auth/screens/doctor_register_screen.dart';
import 'package:roshetta_pro/auth/screens/patient_register_screen.dart';
import 'package:roshetta_pro/auth/screens/pharmacy_register_screen.dart';
import 'package:roshetta_pro/core/component/app_snackbar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/utils/cache_helper.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/doctor_layout.dart';
import 'package:roshetta_pro/patient/patient_layout.dart';
import 'package:roshetta_pro/pharmacy/pharmacy_layout.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if( state is LoginErrorState ){
            if (state.error == 'user-not-found') {
              showToast('No user found for that email.',
                  'Error');
              if (kDebugMode) {
                print('No user found for that email.');
              }
            } else if (state.error == 'wrong-password') {
              showToast('Wrong password provided for that user.',
                  'Error');

              if (kDebugMode) {
                print('Wrong password provided for that user.');
              }
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                LocaleKeys.login.tr(),
                style: TextStyle(
                  fontFamily: 'SST_Arabic',
                  fontWeight: FontWeight.w900,
                  wordSpacing: 1.5,
                  letterSpacing: 1.7,
                  fontSize: 24,
                  color: colorBlue4C,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Lottie.asset('assets/animation/roshetta.json'),
                      myTextFormField(
                          context: context,
                          title: LocaleKeys.email.tr(),
                          hintText:  LocaleKeys.email.tr(),
                          controller: _emailController,
                          prefix: Ic.baseline_email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.thisFieldMustBeFilled.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text),
                      myTextFormField(
                          context: context,
                          title:  LocaleKeys.password.tr(),
                          hintText:  LocaleKeys.password.tr(),
                          controller: _passwordController,
                          prefix: Mdi.lock_outline,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.thisFieldMustBeFilled.tr();
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          isPassword: !AuthCubit.get(context).showPassword
                              ? true
                              : false,
                          suffix: AuthCubit.get(context).suffixIcon,
                          suffixPressed: () {
                            AuthCubit.get(context).changeSuffixIcon(context);
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                      state is LoginLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : myButton(
                              onTap: () => _loginOnTap(context),
                              text: LocaleKeys.login.tr()),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.doNotHaveAnAccount.tr(),
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: colorBlue4C,
                            ),
                          ),
                          InkWell(
                            onTap: () => _registerOnTap(context),
                            child: Text(
                              LocaleKeys.createAccount.tr(),
                              style: TextStyle(
                                fontFamily: 'SST_Arabic',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: colorBlueC0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _loginOnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await AuthCubit.get(context)
          .signIn(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((value) {
        constUId = value;
        CacheHelper.saveData(key: CacheName.uId.name, value: value)
            .then((value) {
          debugPrint('I\'m login and this my Id : $constUId');
          AuthCubit.get(context).getUserData(constUId).then((value) {
            _enterCondition(AuthCubit.get(context).model.userType, context);
          });
        });
        if (kDebugMode) {
          print('--------------------------');
          print(value.toString());
        }
      });
    }
  }

  _enterCondition(String userType, BuildContext context) {
    CacheHelper.saveData(key: CacheName.userType.name, value: userType);
    constUserType=userType;
    if (userType == UserType.patient.name) {
      navigateAndKill(context, PatientLayout());
    } else if (userType == UserType.doctor.name) {
      navigateAndKill(context, DoctorLayout());
    } else if (userType == UserType.pharmacy.name) {
      navigateAndKill(context, PharmacyLayout());
    }

  }

  _registerOnTap(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: colorBlueC0,
          title: Center(
            child: Text(
              LocaleKeys.registerAs.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SST_Arabic',
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: colorGrayF9,
              ),
            ),
          ),
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SimpleDialogOption(
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/doctor_icon.png',
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.doctor.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: colorGrayF9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      navigateTo(context,  DoctorRegisterScreen());
                    },
                  ),
                  SimpleDialogOption(
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/patient_icon.png',
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.patient.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: colorGrayF9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      navigateTo(context,  PatientRegisterScreen());
                    },
                  ),
                  SimpleDialogOption(
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/pharmacy_icon.png',
                            width: 45,
                            height: 45,
                          ),
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.pharmacy.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: colorGrayF9,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      navigateTo(context,  PharmacyRegisterScreen());
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
