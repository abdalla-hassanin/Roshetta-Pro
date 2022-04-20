
class UserModel {
  UserModel({
    required this.uId,
    required this.userType,
  });
  late final String uId;
  late final String userType;

  UserModel.fromJson(Map<String, dynamic> json){
    uId = json['uId'];

    userType = json['userType'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uId'] = uId;

    _data['userType'] = userType;

    return _data;
  }
}