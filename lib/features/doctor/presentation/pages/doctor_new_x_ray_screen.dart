import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/medical_icon.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/features/doctor/presentation/manager/doctor_cubit.dart';
import 'package:roshetta_pro/features/patient/data/models/x_ray_model.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_alert_dialog.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_button.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_text_form_field.dart';
import 'package:roshetta_pro/core/shared_widgets/custom_top_bar.dart';

class DoctorNewXRayScreen extends StatelessWidget {
  final String patientId;

  DoctorNewXRayScreen(this.patientId, {super.key});

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _labNameController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await customAlertDialog(
              context: context,
              message: context.l10n.sureExit,
              onYesTap: (){
                Navigator.of(context).pop(true);
                context.read<DoctorCubit>().emptyPickedImage();
                context.read<DoctorCubit>().getPatientXRays(patientId);
              }) ?? false;
          if (shouldPop) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
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
                    BlocBuilder<DoctorCubit, DoctorState>(
                        builder: (context, state) {
                      return (context.read<DoctorCubit>().pickedImage != null)
                          ? Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  // height: MediaQuery.of(context).size.height*0.25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.file(
                                    context.read<DoctorCubit>().pickedImage!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 8, end: 8),
                                  child: CircleAvatar(
                                    backgroundColor: colorBlueC0,
                                    child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<DoctorCubit>()
                                              .emptyPickedImage();
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
                                    context.read<DoctorCubit>().pickImage();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.image_outlined),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(context.l10n.chooseImage,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ],
                                  )),
                            );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<DoctorCubit, DoctorState>(
                        listener: (context, state) {
                      if (state is XRayUploadImageToStorageError ||
                          state is AddNewXRayError) {
                        String? errorMsg;
                        if (state is XRayUploadImageToStorageError) {
                          errorMsg = state.error;
                        } else if (state is AddNewXRayError) {
                          errorMsg = state.error;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(errorMsg!),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else if (state is XRayUploadImageToStorageSuccess) {
                        context.read<DoctorCubit>().addNewXRay(
                            patientId,
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
                      } else if (state is AddNewXRaySuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.state),
                            backgroundColor: Colors.green,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        context.read<DoctorCubit>().getPatientXRays(patientId);
                        context.read<DoctorCubit>().emptyPickedImage();

                        Navigator.pop(context, true);
                      }
                    }, builder: (context, state) {
                      if (state is XRayUploadImageToStorageLoading ||
                          state is AddNewXRayLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                          text: context.l10n.save,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (context.read<DoctorCubit>().pickedImage !=
                                  null) {
                                context
                                    .read<DoctorCubit>()
                                    .xRayUploadImageToStorage(
                                        context
                                            .read<DoctorCubit>()
                                            .pickedImage!,
                                        patientId);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please pick an image'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          });
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

}
