class DoctorEntity {
  final String uId;
  final String name;
  final String mobilePhone;
  final String email;
  final String address;
  final String imageUrl;
  final String userType;
  final String bio;
  final Map<String, dynamic> specialization;
  final String clinicName;
  final String hospitalName;

  const DoctorEntity(
      {required this.uId,
      required this.name,
      required this.mobilePhone,
      required this.email,
      required this.address,
      required this.imageUrl,
      required this.userType,
      required this.bio,
      required this.specialization,
      required this.clinicName,
      required this.hospitalName
      });
}
