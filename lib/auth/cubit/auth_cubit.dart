import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:roshetta_pro/auth/models/user_model.dart';
import 'package:roshetta_pro/core/models/doctor_model.dart';
import 'package:roshetta_pro/core/models/patient_model.dart';
import 'package:roshetta_pro/core/models/pharmacy_model.dart';
import 'package:roshetta_pro/core/utils/constants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  String suffixIcon = Ic.outline_visibility_off;
  bool showPassword = false;
  void changeSuffixIcon(context) {
    showPassword = !showPassword;
    if (showPassword) {
      suffixIcon = Ic.outline_visibility;
    } else {
      suffixIcon = Ic.outline_visibility_off;
    }
    emit(ChangeSuffixIconState());
  }



  Map<String, dynamic> specializationValue = {};

  changeSpecializationValue(value) {
    specializationValue = value;
    emit(ChangeSpecializationValueState());
  }

  String bloodValue = '';
  changeBloodValue(value) {
    bloodValue = value;
    emit(ChangeBloodValueState());
  }

  String genderValue ='';

  changeGenderValue(value) {
    genderValue = value;
    emit(ChangeGenderValueState());
  }

  int heightValue =100;

  changeHeightValue(value) {
    heightValue = value;
    emit(ChangeHeightValueState());
  }

  int weightValue =50;

  changeWeightValue(value) {
    weightValue = value;
    emit(ChangeWeightValueState());
  }



  Future signIn({
    required String email,
    required String password,
  }) async {
    String? uId;
    emit(LoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(LoginErrorState(error.code));
    });
    return uId;
  }

  void resetPassword({
    required String email,
  }) {
    emit(ResetPasswordLoadingState());
    FirebaseAuth.instance
        .sendPasswordResetEmail(
      email: email,
    )
        .then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ResetPasswordErrorState());
    });
  }

  Future doctorSignUp({
    required String name,
    required String email,
    required String password,
    required String mobilePhone,
    required String address,
    required String bio,
    required String profileImg,
    required Map<String, dynamic> specialization,
    required String clinicName,
    required String hospitalName,
  }) async {
    String? uId;
    emit(SignUpDoctorLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      createDoctor(
        uId: value.user!.uid,
        name: name,
        email: email,
        mobilePhone: mobilePhone,
        address: address,
        bio: bio,
        profileImg: profileImg,
        userType: UserType.doctor.name,
        specialization: specialization,
        clinicName: clinicName,
        hospitalName: hospitalName,
      );
      emit(SignUpDoctorSuccessState(value.user!.uid));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SignUpDoctorErrorState(error.code));
    });
    return uId;
  }

  Future createDoctor({
    required String uId,
    required String name,
    required String email,
    required String mobilePhone,
    required String address,
    required String bio,
    required String profileImg,
    required String userType,
    required Map<String, dynamic> specialization,
    required String clinicName,
    required String hospitalName,
  }) async {
    emit(CreateDoctorLoadingState());
    DoctorModel model = DoctorModel(
      uId: uId,
      name: name,
      mobilePhone: mobilePhone,
      email: email,
      address: address,
      profileImg: profileImg,
      userType: userType,
      specialization: specialization,
      clinicName: clinicName,
      hospitalName: hospitalName,
      bio: bio,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreateDoctorSuccessState(uId));
    }).catchError((error) {
      emit(CreateDoctorErrorState());
    });
  }

  Future patientSignUp({
    required String name,
    required String mobilePhone,
    required String email,
    required String password,
    required String address,
    required String profileImg,
    required String gender,
    required String blood,
    required int height,
    required int weight,
    required String birthDay,
    required String bio,
  }) async {
    String? uId;
    emit(SignUpPatientLoadingState());
  await  FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      createPatient(
          uId: value.user!.uid,
          name: name,
          mobilePhone: mobilePhone,
          email: email,
          address: address,
          profileImg: profileImg,
          userType: UserType.patient.name,
          gender: gender,
          blood: blood,
          height: height,
          weight: weight,
          birthDay: birthDay,
          bio: bio);
      emit(SignUpPatientSuccessState(value.user!.uid));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SignUpPatientErrorState(error.code));
    });
    return uId;
  }

  Future createPatient({
    required String uId,
    required String name,
    required String mobilePhone,
    required String email,
    required String address,
    required String profileImg,
    required String userType,
    required String gender,
    required String blood,
    required int height,
    required int weight,
    required String birthDay,
    required String bio,
  }) async {
    emit(CreatePatientLoadingState());
    PatientModel model = PatientModel(
        uId: uId,
        name: name,
        mobilePhone: mobilePhone,
        email: email,
        address: address,
        profileImg: profileImg,
        userType: userType,
        gender: gender,
        blood: blood,
        height: height,
        weight: weight,
        birthDay: birthDay,
        bio: bio);
   await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreatePatientSuccessState(uId));
    }).catchError((error) {
      emit(CreatePatientErrorState());
    });
  }

  Future pharmacySignUp({
    required String name,
    required String mobilePhone,
    required String email,
    required String password,
    required String address,
    required String profileImg,
    required String bio,
  }) async {
    String? uId;
    emit(SignUpPharmacyLoadingState());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      createPharmacy(
          uId: value.user!.uid,
          name: name,
          mobilePhone: mobilePhone,
          email: email,
          address: address,
          profileImg: profileImg,
          userType: UserType.pharmacy.name,
          bio: bio);
      emit(SignUpPharmacySuccessState(value.user!.uid));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(SignUpPharmacyErrorState(error.code));
    });
    return uId;
  }

  Future createPharmacy({
    required String uId,
    required String name,
    required String mobilePhone,
    required String email,
    required String address,
    required String profileImg,
    required String userType,
    required String bio,
  }) async {
    emit(CreatePharmacyLoadingState());
    PharmacyModel model = PharmacyModel(
      uId: uId,
      name: name,
      mobilePhone: mobilePhone,
      email: email,
      address: address,
      profileImg: profileImg,
      userType: userType,
      bio: bio,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {
      emit(CreatePharmacySuccessState(uId));
    }).catchError((error) {
      emit(CreatePharmacyErrorState());
    });
  }

  dynamic model;

  Future getUserData(String? uid) async {
    emit(UserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      UserModel userModel = UserModel.fromJson(value.data()!);

      if (userModel.userType == UserType.patient.name) {
        model = PatientModel.fromJson(value.data()!);
      } else if (userModel.userType == UserType.doctor.name) {
        model = DoctorModel.fromJson(value.data()!);
      } else if (userModel.userType == UserType.pharmacy.name) {
        model = PharmacyModel.fromJson(value.data()!);
      }
      emit(UserSuccessState());
    }).catchError((error) {
      emit(UserErrorState());
    });
  }
}
