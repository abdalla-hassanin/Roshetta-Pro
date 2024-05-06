import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:lottie/lottie.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/manager/patient_auth_cubit.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_text_form_field.dart';

class PatientSignInScreen extends StatelessWidget {
  PatientSignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                BlocBuilder<PatientAuthCubit, PatientAuthState>(
                  builder: (context, state) {
                    if (state is PatientSignInLoading ||
                        state is GetPatientLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PatientSignInError ||
                        state is GetPatientError) {
                      String? errorMsg;
                      if (state is PatientSignInError) {
                        errorMsg = state.error;
                      } else if (state is GetPatientError) {
                        errorMsg = state.error;
                      }
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMsg!),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      });
                    }
                    if (state is PatientSignInSuccess) {
                      context.read<PatientAuthCubit>().getPatient();
                    }
                    if (state is GetPatientSuccess) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.patientScreen,
                            arguments: state.patientEntity,
                            (route) => false);
                      });
                    }

                    return CustomButton(
                        text: context.l10n.login,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final String email = _emailController.text;
                            final String password = _passwordController.text;
                            context
                                .read<PatientAuthCubit>()
                                .patientSignIn(email, password);
                          }
                        });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
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
                        Navigator.pushNamed(
                            context, Routes.patientSignUpScreen);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
