import 'package:roshetta_pro/features/doctor_auth/domain/entities/doctor_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel(
      {required super.uId,
      required super.name,
      required super.mobilePhone,
      required super.email,
      required super.address,
      required super.imageUrl,
      required super.userType,
      required super.bio,
      required super.specialization,
      required super.clinicName,
      required super.hospitalName});

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'mobilePhone': mobilePhone,
      'email': email,
      'address': address,
      'imageUrl': imageUrl,
      'userType': userType,
      'bio': bio,
      'specialization': specialization,
      'clinicName': clinicName,
      'hospitalName': hospitalName
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      uId: map['uId'],
      name: map['name'],
      mobilePhone: map['mobilePhone'],
      email: map['email'],
      address: map['address'],
      imageUrl: map['imageUrl'],
      userType: map['userType'],
      bio: map['bio'],
      specialization: map['specialization'],
      clinicName: map['clinicName'],
      hospitalName: map['hospitalName'],
    );
  }
}
