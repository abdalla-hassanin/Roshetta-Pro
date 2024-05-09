import 'package:flutter/material.dart';
import 'package:roshetta_pro/core/routes.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_button.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomTopBar(title:context.l10n.signup),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Choose your system', style: TextStyle(fontSize: 24)),
              const Text('to start using', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Pharmacy',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.pharmacySignUpScreen),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Patient',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.patientSignUpScreen),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Doctor',
                onTap: () =>
                    Navigator.pushNamed(context, Routes.doctorSignUpScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
