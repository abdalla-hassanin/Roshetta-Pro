import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/auth/presentation/manager/auth_cubit.dart';

class CustomSpecialityDropDownField extends StatelessWidget {
  final String title;
  final String hintText;
  final List items;

  const CustomSpecialityDropDownField({
    super.key,
    required this.title,
    required this.hintText,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection:
                Directionality.of(context) == material.TextDirection.rtl
                    ? material.TextDirection.rtl
                    : material.TextDirection.ltr,
            children: [
              Text(
                title,
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
                child: DropdownButtonFormField(
                  itemHeight: kMinInteractiveDimension * 1.25,
                  validator: (value) {
                    if (value == null) {
                      return context.l10n.thisFieldMustBeFilled;
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: colorBlue4C,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: colorGray94,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorBlueC0, width: 2),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: colorGray94, width: 2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: colorGray94, width: 2)),
                  ),
                  onChanged: (value) {
                    context
                        .read<AuthCubit>()
                        .doctorChangeSpecializationValue(value);
                  },
                  icon: Iconify(
                    Ic.twotone_keyboard_arrow_down,
                    color: colorBlueC0,
                  ),
                  items: items.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Image.asset(
                            e['image'],
                            fit: BoxFit.cover,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                              Directionality.of(context) ==
                                      material.TextDirection.rtl
                                  ? e['specialityAr']
                                  : e['specialityEn'],
                              style: TextStyle(
                                fontFamily: 'SST_Arabic',
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: colorBlue4C,
                              )),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              )
            ]);
      },
    );
  }
}
