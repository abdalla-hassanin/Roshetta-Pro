class PatientEntity {
  final String uId;
  final String name;
  final String mobileNumber;
  final String email;
  final String address;
  final String imageUrl;
  final String userType;
  final String bio;
  final String gender;
  final String blood;
  final int height;
  final int weight;
  final String birthDay;

  const PatientEntity(
      {required this.uId,
      required this.name,
      required this.mobileNumber,
      required this.email,
      required this.address,
      required this.imageUrl,
      required this.userType,
      required this.bio,
      required this.gender,
      required this.blood,
      required this.height,
      required this.weight,
      required this.birthDay
      });
}
