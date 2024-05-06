import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_sign_up_params.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/manager/patient_auth_cubit.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/widgets/custom_blood_drop_down_field.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/widgets/custom_date_picker_field.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/widgets/custom_gender_radio.dart';
import 'package:roshetta_pro/features/patient_auth/presentation/widgets/custom_number_picker.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_text_form_field.dart';

class PatientSingUpScreen extends StatefulWidget {
  const PatientSingUpScreen({super.key});

  @override
  State<PatientSingUpScreen> createState() => _PatientSingUpScreenState();
}

class _PatientSingUpScreenState extends State<PatientSingUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool value) {
        context.read<PatientAuthCubit>().patientBloodValue = '';
        context.read<PatientAuthCubit>().patientGenderValue = '';
        context.read<PatientAuthCubit>().patientHeightValue = 100;
        context.read<PatientAuthCubit>().patientWeightValue = 50;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            context.l10n.createAccountPatient,
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
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage!) as ImageProvider<Object>
                        : const AssetImage(
                            'assets/images/user-image-default.png'),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          _pickImage();
                        },
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
                  ),
                  CustomTextFormField(
                    title: context.l10n.name,
                    hintText: context.l10n.userName,
                    controller: _nameController,
                    prefix: Ion.person_outline,
                  ),
                  CustomTextFormField(
                      title: context.l10n.email,
                      hintText: context.l10n.email,
                      controller: _emailController,
                      prefix: Ic.baseline_email,
                      keyboardType: TextInputType.emailAddress),
                  CustomTextFormField(
                    title: context.l10n.password,
                    hintText: context.l10n.password,
                    controller: _passwordController,
                    prefix: Mdi.lock_outline,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  CustomTextFormField(
                      title: context.l10n.numberPhone,
                      hintText: context.l10n.numberPhone,
                      controller: _numberPhoneController,
                      prefix: Ic.baseline_phone_enabled,
                      keyboardType: TextInputType.phone),
                  CustomTextFormField(
                      title: context.l10n.address,
                      hintText: context.l10n.address,
                      controller: _addressController,
                      prefix: Ic.baseline_location_on,
                      keyboardType: TextInputType.streetAddress),
                  CustomTextFormField(
                    title: context.l10n.aboutYourCv,
                    hintText: context.l10n.aboutYou,
                    controller: _bioController,
                    prefix: Ic.outline_wb_incandescent,
                    minLines: 3,
                    maxLines: 4,
                  ),
                  CustomDatePickerField(
                      title: context.l10n.birthDay,
                      hintText: context.l10n.birthDay,
                      controller: _birthDayController),
                  const CustomGenderRadio(),
                  const CustomBloodDropDownField(),
                  BlocBuilder<PatientAuthCubit, PatientAuthState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        CustomNumberPicker(
                            title: context.l10n.height,
                            minValue: 50,
                            maxValue: 250,
                            onChanged: (value) => context
                                .read<PatientAuthCubit>()
                                .patientChangeHeightValue(value),
                            value: context
                                .read<PatientAuthCubit>()
                                .patientHeightValue),
                        CustomNumberPicker(
                            title: context.l10n.weight,
                            minValue: 20,
                            maxValue: 200,
                            onChanged: (value) => context
                                .read<PatientAuthCubit>()
                                .patientChangeWeightValue(value),
                            value: context
                                .read<PatientAuthCubit>()
                                .patientWeightValue),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 24,
                  ),
                  BlocBuilder<PatientAuthCubit, PatientAuthState>(
                    builder: (context, state) {
                      if (state is PatientSignUpLoading ||
                          state is PatientUploadImageToStorageLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is PatientSignUpError ||
                          state is PatientUploadImageToStorageError) {
                        String? errorMsg;
                        if (state is PatientSignUpError) {
                          errorMsg = state.error;
                        } else if (state is PatientUploadImageToStorageError) {
                          errorMsg = '${state.error}-UploadImageToStorageError';
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
                      if (state is PatientUploadImageToStorageSuccess) {
                        final String name = _nameController.text;
                        final String email = _emailController.text;
                        final String password = _passwordController.text;
                        final String mobileNumber = _numberPhoneController.text;
                        final String address = _addressController.text;
                        final String bio = _bioController.text;
                        final String birthDay = _birthDayController.text;
                        final String gender =
                            context.read<PatientAuthCubit>().patientGenderValue;
                        final String blood =
                            context.read<PatientAuthCubit>().patientBloodValue;
                        final int height =
                            context.read<PatientAuthCubit>().patientHeightValue;
                        final int weight =
                            context.read<PatientAuthCubit>().patientWeightValue;

                        context
                            .read<PatientAuthCubit>()
                            .patientSignUp(PatientSignUpParams(
                              name: name,
                              email: email,
                              password: password,
                              mobileNumber: mobileNumber,
                              address: address,
                              bio: bio,
                              userType: FireBaseEndPoints.patient,
                              imageUrl: state.imageUrl,
                              birthDay: birthDay,
                              gender: gender,
                              blood: blood,
                              height: height,
                              weight: weight,
                            ));
                      }
                      if (state is PatientSignUpSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.state),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                          Navigator.pop(context);
                        });
                      }

                      return CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate() &&
                                _pickedImage != null) {
                              final File imageFile = _pickedImage!;
                              context
                                  .read<PatientAuthCubit>()
                                  .patientUploadImageToStorage(imageFile);
                            }
                          },
                          text: context.l10n.createAccount);
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.alreadyHaveAnAccount,
                        style: TextStyle(
                          fontFamily: 'SST_Arabic',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: colorBlue4C,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          context.l10n.login,
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
      ),
    );
  }

  // Method to handle image picking
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // If image is picked, update the state
      _pickedImage = File(pickedImage.path);
      setState(() {});
    } else {
      // If no image is picked
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }
}
