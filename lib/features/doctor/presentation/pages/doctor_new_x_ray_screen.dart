import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/medical_icon.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_button.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_text_form_field.dart';
import 'package:roshetta_pro/features/pharmacy/presentation/widgets/custom_top_bar.dart';

class DoctorNewXRayScreen extends StatefulWidget {
  final String patientId;

  const DoctorNewXRayScreen(this.patientId, {super.key});

  @override
  State<DoctorNewXRayScreen> createState() => _DoctorNewXRayScreenState();
}

class _DoctorNewXRayScreenState extends State<DoctorNewXRayScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _labNameController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    //TODO: add dialog if pop screen without saving
    return Scaffold(
      appBar: CustomTopBar(
        title: context.l10n.newXRaysAnalyzes,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormField(
                    title: context.l10n.title,
                    hintText: context.l10n.writeTitle,
                    controller: _titleController,
                    prefix: Mdi.format_title,
                    minLines: 1,
                    maxLines: 1),
                CustomTextFormField(
                    title: context.l10n.labName,
                    hintText: context.l10n.labName,
                    controller: _labNameController,
                    prefix: MedicalIcon.i_laboratory,
                    minLines: 1,
                    maxLines: 1),
                CustomTextFormField(
                    title: context.l10n.notes,
                    hintText: context.l10n.writeXRaysAnalyzes,
                    controller: _noteController,
                    prefix: Ic.baseline_notes,
                    minLines: 3,
                    maxLines: 4),
                const SizedBox(
                  height: 10,
                ),
                (_pickedImage != null)
                    ? Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            // height: MediaQuery.of(context).size.height*0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.file(
                              _pickedImage!,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                top: 8, end: 8),
                            child: CircleAvatar(
                              backgroundColor: colorBlueC0,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _pickedImage = null;
                                    });
                                  },
                                  icon: Iconify(Ic.baseline_close,
                                      color: colorGrayF9)),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: TextButton(
                            onPressed: () {
                              _pickImage();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.image_outlined),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(context.l10n.chooseImage,
                                    style: const TextStyle(color: Colors.grey)),
                              ],
                            )),
                      ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<DoctorCubit, DoctorState>(
                    builder: (context, state) {
                  if (state is XRayUploadImageToStorageLoading ||
                      state is AddNewXRayLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is XRayUploadImageToStorageError ||
                      state is AddNewXRayError) {
                    String? errorMsg;
                    if (state is XRayUploadImageToStorageError) {
                      errorMsg = state.error;
                    } else if (state is AddNewXRayError) {
                      errorMsg = state.error;
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMsg!),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    });
                  }
                  if (state is XRayUploadImageToStorageSuccess) {
                    context.read<DoctorCubit>().addNewXRay(
                        widget.patientId,
                        XRayModel(
                            doctorId: 'doctorId',
                            doctorName: 'doctorName',
                            doctorImg: 'doctorImg',
                            labName: _labNameController.text,
                            date: getDate(),
                            xRayImg: state.imageUrl,
                            xRayTitle: _titleController.text,
                            notes: _noteController.text,
                            dateTime: Timestamp.now()));
                  }
                  if (state is AddNewXRaySuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.state),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                      context
                          .read<DoctorCubit>()
                          .getPatientXRays(widget.patientId);

                      Navigator.pop(context);
                    });
                  }
                  return CustomButton(
                      text: context.l10n.save,
                      onTap: () {
                        if (_formKey.currentState!.validate() &&
                            _pickedImage != null) {
                          context.read<DoctorCubit>().xRayUploadImageToStorage(
                              _pickedImage!, widget.patientId);
                        }
                      });
                }),
              ],
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
    }
  }
}
