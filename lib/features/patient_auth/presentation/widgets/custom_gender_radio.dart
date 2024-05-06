import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/manager/patient_auth_cubit.dart';

class CustomGenderRadio extends StatelessWidget {
  const CustomGenderRadio({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientAuthCubit, PatientAuthState>(
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection:
                Directionality.of(context) == material.TextDirection.rtl
                    ? material.TextDirection.rtl
                    : material.TextDirection.ltr,
            children: [
              Text(
                context.l10n.gender,
                style: TextStyle(
                  fontFamily: 'SST_Arabic',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: colorBlue4C,
                ),
              ),
              Directionality(
                  textDirection:
                      Directionality.of(context) == material.TextDirection.rtl
                          ? material.TextDirection.rtl
                          : material.TextDirection.ltr,
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: colorBlueC0,
                            groupValue: context
                                .read<PatientAuthCubit>()
                                .patientGenderValue,
                            value: 'male',
                            onChanged: (value) {
                              context
                                  .read<PatientAuthCubit>()
                                  .patientChangeGenderValue(value);
                            },
                          ),
                          Text(
                            context.l10n.male,
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: colorBlue4C,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Radio(
                            activeColor: colorBlueC0,
                            groupValue: context
                                .read<PatientAuthCubit>()
                                .patientGenderValue,
                            value: 'female',
                            onChanged: (value) {
                              context
                                  .read<PatientAuthCubit>()
                                  .patientChangeGenderValue(value);
                            },
                          ),
                          Text(
                            context.l10n.female,
                            style: TextStyle(
                              fontFamily: 'SST_Arabic',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: colorBlue4C,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ))
            ]);
      },
    );
  }
}
