import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:roshetta_pro/auth/cubit/auth_cubit.dart';
import 'package:roshetta_pro/core/component/app_snackbar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_speciality_drop_down_field.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/utils/cache_helper.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/doctor_layout.dart';

import '../../core/utils/doctors_specialty_list.dart';

class DoctorRegisterScreen extends StatelessWidget {
  DoctorRegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _hospitalNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
           if( state is SignUpDoctorErrorState ){
             if (state.error == 'weak-password') {
               showToast('The password provided is too weak.',
                   'Error');
               if (kDebugMode) {
                 print('The password provided is too weak.');
               }
             } else if (state.error == 'email-already-in-use') {
               showToast('The account already exists for that email.',
                   'Error');

               if (kDebugMode) {
                 print('The account already exists for that email.');
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
                  LocaleKeys.createAccountDoctor.tr(),
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
                        CircleAvatar(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: colorBlueC0,
                                radius: 15,
                                child: Iconify(
                                  Ic.baseline_plus,
                                  color: colorGrayF9,
                                ),
                              ),
                            ),
                          ),
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: const AssetImage(
                              'assets/images/user-image-default.png'),
                        ),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.name.tr(),
                            hintText: LocaleKeys.quatrainName.tr(),
                            controller: _nameController,
                            prefix: Ion.person_outline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.email.tr(),
                            hintText: LocaleKeys.email.tr(),
                            controller: _emailController,
                            prefix: Ic.baseline_email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.password.tr(),
                            hintText: LocaleKeys.password.tr(),
                            controller: _passwordController,
                            prefix: Mdi.lock_outline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: !AuthCubit.get(context).showPassword
                                ? true
                                : false,
                            suffix: AuthCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              AuthCubit.get(context).changeSuffixIcon(context);
                            }),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.numberPhone.tr(),
                            hintText: LocaleKeys.numberPhone.tr(),
                            controller: _numberPhoneController,
                            prefix: Ic.baseline_phone_enabled,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.address.tr(),
                            hintText: LocaleKeys.address.tr(),
                            controller: _addressController,
                            prefix: Ic.baseline_location_on,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.streetAddress),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.aboutYourCv.tr(),
                            hintText: LocaleKeys.aboutYou.tr(),
                            controller: _bioController,
                            prefix: Ic.outline_wb_incandescent,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.hospitalName.tr(),
                            hintText: LocaleKeys.hospitalName.tr(),
                            controller: _hospitalNameController,
                            prefix: Healthicons.hospital_symbol_outline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        myTextFormField(
                            context: context,
                            title: LocaleKeys.clinicName.tr(),
                            hintText: LocaleKeys.clinicName.tr(),
                            controller: _clinicNameController,
                            prefix: Healthicons.clinical_fe_outline,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return LocaleKeys.thisFieldMustBeFilled.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text),
                        mySpecialityDropDownField(
                            title: LocaleKeys.medicalSpecialty.tr(),
                            hintText: LocaleKeys.chooseSpecialty.tr(),
                            context: context,
                            items: doctorsSpecialtyList,
                            authCubit: AuthCubit.get(context)),
                        const SizedBox(
                          height: 24,
                        ),
                        state is SignUpDoctorLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : myButton(
                                onTap: () => _registerOnTap(context),
                                text: LocaleKeys.createAccount.tr()),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.alreadyHaveAnAccount.tr(),
                              style: TextStyle(
                                fontFamily: 'SST_Arabic',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: colorBlue4C,
                              ),
                            ),
                            InkWell(
                              onTap: () => pop(context),
                              child: Text(
                                LocaleKeys.login.tr(),
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
        ));
  }



  _registerOnTap(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await AuthCubit.get(context)
          .doctorSignUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        mobilePhone: _numberPhoneController.text,
        address: _addressController.text,
        bio: _bioController.text,
        profileImg:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7PpUThdtq_IUCP4oZ1nnmqSbGYBBDS6odbA&usqp=CAU',
        specialization: AuthCubit.get(context).specializationValue,
        clinicName: _clinicNameController.text,
        hospitalName: _hospitalNameController.text,
      )
          .then((value) {
        constUId = value;
        CacheHelper.saveData(key: CacheName.uId.name, value: value)
            .then((value) {
          debugPrint('I\'m Signup Doctor and this my Id : $constUId');
          CacheHelper.saveData(
              key: CacheName.userType.name, value: UserType.doctor.name);
          constUserType = UserType.doctor.name;
          navigateAndKill(context, DoctorLayout());
        });
      });
    }
  }
}
