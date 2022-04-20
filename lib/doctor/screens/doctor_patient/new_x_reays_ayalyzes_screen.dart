import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/medical_icon.dart';
import 'package:roshetta_pro/core/component/my_app_top_bar.dart';
import 'package:roshetta_pro/core/component/my_button.dart';
import 'package:roshetta_pro/core/component/my_text_form_field.dart';
import 'package:roshetta_pro/core/utils/constants.dart';
import 'package:roshetta_pro/core/utils/local_keys.g.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_cubit.dart';
import 'package:roshetta_pro/doctor/cubit/doctor_state.dart';

import '../../../core/component/app_snackbar.dart';
import '../../../core/component/my_dialog_warning.dart';

class NewXRaysAnalysisScreen extends StatelessWidget {
  NewXRaysAnalysisScreen({Key? key}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _labNameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorCubit, DoctorState>(listener: (context, state) {
      if (state is NewXRaysAnalysisSuccessState) {
        DoctorCubit.get(context).getXRaysAnalysisModel(uId: DoctorCubit.get(context).patientModel!.uId);
        clearScreen(DoctorCubit.get(context));
        pop(context);
      }
    }, builder: (context, state) {
      DoctorCubit doctorCubit = DoctorCubit.get(context);
      dynamic postPic = doctorCubit.postImage;

      return WillPopScope(
          onWillPop: () async {
            final shouldPop = await myDialogWarning(
                context: context,
                message: LocaleKeys.exitPatientProfile.tr(),
                onYesTap: () {
                  clearScreen(doctorCubit);
                  Navigator.pop(context, true);
                });
            return shouldPop ?? false;
          },
          child: Scaffold(
        appBar: myAppTopBar(
          context: context,
          title: LocaleKeys.newXRaysAnalyzes.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is NewXRaysAnalysisLoadingState)
                    Column(
                      children: const [
                        LinearProgressIndicator(),
                        SizedBox(height: 10),
                      ],
                    ),
                  myTextFormField(  context: context,
                      title: LocaleKeys.title.tr(),
                      hintText: LocaleKeys.writeTitle.tr(),
                      controller: _titleController,
                      prefix: Mdi.format_title,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.thisFieldMustBeFilled.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 1),
                  myTextFormField(
                      context: context,
                      title: LocaleKeys.labName.tr(),
                      hintText: LocaleKeys.labName.tr(),
                      controller: _labNameController,
                      prefix: MedicalIcon.i_laboratory,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.thisFieldMustBeFilled.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 1),
                  myTextFormField(context: context,
                      title: LocaleKeys.notes.tr(),
                      hintText: LocaleKeys.writeXRaysAnalyzes.tr(),
                      controller: _noteController,
                      prefix: Ic.baseline_notes,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.thisFieldMustBeFilled.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      minLines: 3,
                      maxLines: 4),
                  const SizedBox(
                    height: 10,
                  ),
                  if (doctorCubit.postImage == null)
                    Center(
                      child: TextButton(
                          onPressed: () {
                            doctorCubit.getPostImage();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children:  [
                              const Icon(Icons.image_outlined),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(LocaleKeys.chooseImage.tr(),
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          )),
                    ),
                  if (doctorCubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          // height: MediaQuery.of(context).size.height*0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.file(
                            postPic,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(top: 8, end: 8),
                          child: CircleAvatar(
                            backgroundColor: colorBlueC0,
                            child: IconButton(
                                onPressed: () {
                                  doctorCubit.popPostImage();
                                },
                                icon: Iconify(Ic.baseline_close,
                                    color: colorGrayF9)),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  myButton(
                      text: LocaleKeys.save.tr(),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (doctorCubit.postImage != null) {
                            doctorCubit.createNewXRaysAnalysis(
                                xRayTitle: _titleController.text,
                                doctorId: doctorCubit.doctorModel!.uId,
                                doctorName: doctorCubit.doctorModel!.name,
                                doctorImg: doctorCubit.doctorModel!.profileImg,
                                labName: _labNameController.text,
                                date: getDate(),
                                notes: _noteController.text);

                          } else {
                            showToast('Please enter X-ray or Analysis image',
                                'Error');
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
  clearScreen(DoctorCubit cubit) {
    cubit.popPostImage();
    _titleController.clear();
    _labNameController.clear();
    _noteController.clear();
  }
}
