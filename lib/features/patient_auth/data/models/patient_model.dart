import 'package:roshetta_pro/features/patient_auth/domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  PatientModel(
      {required super.uId,
      required super.name,
      required super.mobileNumber,
      required super.email,
      required super.address,
      required super.imageUrl,
      required super.userType,
      required super.bio,
      required super.gender,
      required super.blood,
      required super.height,
      required super.weight,
      required super.birthDay});

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'mobileNumber': mobileNumber,
      'email': email,
      'address': address,
      'imageUrl': imageUrl,
      'userType': userType,
      'bio': bio,
      'gender': gender,
      'blood': blood,
      'height': height,
      'weight': weight,
      'birthDay': birthDay,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      uId: map['uId'],
      name: map['name'],
      mobileNumber: map['mobileNumber'],
      email: map['email'],
      address: map['address'],
      imageUrl: map['imageUrl'],
      userType: map['userType'],
      bio: map['bio'],
      gender: map['gender'],
      blood: map['blood'],
      height: map['height'],
      weight: map['weight'],
      birthDay: map['birthDay'],
    );
  }
}
