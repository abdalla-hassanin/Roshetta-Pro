class PatientModel {
  PatientModel(
      {required this.uId,
      required this.name,
      required this.mobilePhone,
      required this.email,
      required this.address,
      required this.profileImg,
      required this.userType,
      required this.gender,
      required this.blood,
      required this.height,
      required this.weight,
      required this.birthDay,
      required this.bio});

  late final String uId;
  late final String name;
  late final String mobilePhone;
  late final String email;
  late final String address;
  late final String profileImg;
  late final String userType;
  late final String gender;
  late final String blood;
  late final int height;
  late final int weight;
  late final String birthDay;
  late final String bio;

  PatientModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    name = json['name'];
    mobilePhone = json['mobilePhone'];
    email = json['email'];
    address = json['address'];
    profileImg = json['profileImg'];
    userType = json['userType'];
    gender = json['gender'];
    blood = json['blood'];
    height = json['height'];
    weight = json['weight'];
    birthDay = json['birthDay'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uId'] = uId;
    _data['name'] = name;
    _data['mobilePhone'] = mobilePhone;
    _data['email'] = email;
    _data['address'] = address;
    _data['profileImg'] = profileImg;
    _data['userType'] = userType;
    _data['gender'] = gender;
    _data['blood'] = blood;
    _data['height'] = height;
    _data['weight'] = weight;
    _data['birthDay'] = birthDay;
    _data['bio'] = bio;
    return _data;
  }
}
