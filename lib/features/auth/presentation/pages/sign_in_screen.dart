import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/auth/presentation/manager/auth_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // if (state is GetPatientLoading ||
        //     state is GetPharmacyLoading ||
        //     state is GetDoctorLoading) {
        //   showDialog(
        //     context: context,
        //     builder: (context) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     },
        //   );
        // } else
        if (state is GetPatientError ||
            state is GetPharmacyError ||
            state is GetDoctorError) {
          String? errorText;
          if (state is GetPatientError) {
            errorText = state.error;
          } else if (state is GetPharmacyError) {
            errorText = state.error;
          } else if (state is GetDoctorError) {
            errorText = state.error;
          }
          // Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorText!),
            ),
          );
        } else if (state is GetPatientSuccess) {
          // Navigator.pop(context);

          Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.patientScreen,
              arguments: state.patientEntity,
              (route) => false);
        } else if (state is GetPharmacySuccess) {
          // Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.pharmacyScreen,
              arguments: state.pharmacyEntity,
              (route) => false);
        } else if (state is GetDoctorSuccess) {
          // Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.doctorScreen,
            arguments: state.doctorEntity,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something Went Wrong"),
                );
              } else if (snapshot.hasData) {
                // User is signed in
                User user = snapshot.data!;
                getUserType(user).then((value) {
                  switch (value) {
                    case FireBaseEndPoints.patient:
                      context.read<AuthCubit>().getPatient();
                      break;
                    case FireBaseEndPoints.pharmacy:
                      context.read<AuthCubit>().getPharmacy();
                      break;
                    case FireBaseEndPoints.doctor:
                      context.read<AuthCubit>().getDoctor();
                      break;
                    default:
                      break;
                  }
                });
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                // User is not signed in
                return _buildSignInForm(context);
              }
            });
      },
    );
  }

  Widget _buildSignInForm(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            context.l10n.login,
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
                  CustomTextFormField(
                    title: context.l10n.email,
                    hintText: context.l10n.email,
                    controller: _emailController,
                    prefix: Ic.baseline_email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    title: context.l10n.password,
                    hintText: context.l10n.password,
                    controller: _passwordController,
                    prefix: Mdi.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    suffix: Ic.outline_visibility_off,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _buildSignInButton(context),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildCreateAccountText(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildSignInButton(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignInLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomButton(
            text: context.l10n.login,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                final String email = _emailController.text;
                final String password = _passwordController.text;
                context.read<AuthCubit>().signIn(email, password);
              }
            });
      },
    );
  }

  Widget _buildCreateAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.doNotHaveAnAccount,
          style: TextStyle(
            fontFamily: 'SST_Arabic',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: colorBlue4C,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.signUpScreen);
          },
          child: Text(
            context.l10n.createAccount,
            style: TextStyle(
              fontFamily: 'SST_Arabic',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: colorBlueC0,
            ),
          ),
        ),
      ],
    );
  }

  Future<String> getUserType(User user) async {
    return await FirebaseFirestore.instance
        .collection(FireBaseEndPoints.users)
        .doc(user.uid)
        .get()
        .then((value) => value.data()![FireBaseEndPoints.userType] as String);
  }
}
