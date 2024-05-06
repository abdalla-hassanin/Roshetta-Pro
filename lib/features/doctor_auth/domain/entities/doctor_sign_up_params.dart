class DoctorSignUpParams {
  final String name;
  final String email;
  final String mobilePhone;
  final String password;
  final String address;
  final String imageUrl;
  final String userType;
  final String bio;
  final Map<String, dynamic> specialization;
  final String clinicName;
  final String hospitalName;


  DoctorSignUpParams({
    required this.name,
    required this.email,
    required this.mobilePhone,
    required this.password,
    required this.address,
    required this.imageUrl,
    required this.userType,
    required this.bio,
    required this.specialization,
    required this.clinicName,
    required this.hospitalName
  });
}
