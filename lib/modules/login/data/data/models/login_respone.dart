import 'package:json_annotation/json_annotation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'login_respone.g.dart';

@JsonSerializable()
class LoginResponse {
  String message;
  @JsonKey(name: 'data')
  UserData? userData;
  bool status;
  int code;

  LoginResponse({
    required this.message,
    this.userData,
    required this.status,
    required this.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class UserData {
  String? token;
  @JsonKey(name: 'username')
  String? userName;

  UserData({
    this.token,
    this.userName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
