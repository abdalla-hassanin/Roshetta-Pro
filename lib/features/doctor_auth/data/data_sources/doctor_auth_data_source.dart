import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:roshetta_pro/core/utils/firebase_end_points.dart';
import 'package:roshetta_pro/features/doctor_auth/data/models/doctor_model.dart';
import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_sign_up_params.dart';

class DoctorAuthDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> doctorSignIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      auth.currentUser!.reload();

      return auth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'Your email is not a valid email';
      }
      if (e.code == 'user-not-found') {
        throw 'This email not registered yet';
      }
      if (e.code == 'wrong-password') {
        throw 'Your password is incorrect';
      }
      if (e.code == 'invalid-credential') {
        throw 'Please check your email and password again';
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> doctorSignUp(DoctorSignUpParams params) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      DoctorModel doctorModel = DoctorModel(
        uId: auth.currentUser!.uid,
        name: params.name,
        email: params.email,
        mobilePhone: params.mobilePhone,
        address: params.address,
        bio: params.bio,
        imageUrl: params.imageUrl,
        userType: params.userType,
        specialization: params.specialization,
        clinicName: params.clinicName,
        hospitalName: params.hospitalName,
      );
      await firestore.collection(FireBaseEndPoints.users).doc(auth.currentUser!.uid).set(
            doctorModel.toMap(),
          );

      return 'Signed up successfully';
    } on FirebaseAuthException catch (e) {
      await storage.refFromURL(params.imageUrl).delete();
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();
      }
      if (e.code == 'weak-password') {
        throw 'Your password is too weak';
      }
      if (e.code == 'email-already-in-use') {
        throw 'This email is already in use';
      }
      if (e.code == 'invalid-email') {
        throw 'Your email is not a valid email';
      }
      if (e.code == 'invalid-credential') {
        throw 'Please check your email and password again';
      } else {
        throw e.toString();
      }
    }
  }

  Future<String> doctorUploadImageToStorage(File image) async {
    try {
      final ref = storage.ref().child(
          '${FireBaseEndPoints.pathDoctorUploadImage}/${DateTime.now().microsecondsSinceEpoch}${image.path.split('/').last}');
      await ref.putFile(File(image.path));
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  Future<String> doctorSignOut() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        await auth.signOut();
        return 'Logged out successfully';
      } else {
        throw 'User not logged in';
      }
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }

  Future<String> doctorForgotPassword(String email) async {
    try {
      final result = await firestore
          .collection(FireBaseEndPoints.users)
          .where(FireBaseEndPoints.email, isEqualTo: email)
          .get();

      if (result.docs.length == 1) {
        await auth.sendPasswordResetEmail(email: email);
        return 'Password reset email sent';
      } else {
        throw 'This email not registered yet';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw 'Your email is not a valid email';
      }
      if (e.code == 'user-not-found') {
        throw 'This email not registered yet';
      } else {
        throw e.toString();
      }
    }
  }

  Future<DoctorModel> getDoctor() async {
    try {
      final currentUser = auth.currentUser;
      try {
        final result = await firestore
            .collection(FireBaseEndPoints.users)
            .doc(currentUser!.uid)
            .get()
            .then((value) {
          if (value.data()?[FireBaseEndPoints.userType] == FireBaseEndPoints.doctor) {
            return value;
          } else {
            throw 'User is not a doctor';
          }
        });
        return DoctorModel.fromMap(result.data()!);
      } on FirebaseException catch (e) {
        throw e.toString();
      }
    } on FirebaseAuthException catch (e) {
      throw e.toString();
    }
  }
}
