class PatientSignUpParams {
  final String name;
  final String email;
  final String mobileNumber;
  final String password;
  final String address;
  final String imageUrl;
  final String userType;
  final String bio;
  final String gender;
  final String blood;
  final int height;
  final int weight;
  final String birthDay;


  PatientSignUpParams({
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
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
