class LoginModel
{
  late String? jwt;
  late String? refreshToken;
  late String? expirationOfJwt;
  late String? expirationOfRefreshToken;
  late bool success;
  late bool emailConfirmed;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    jwt = json['jwt'];
    refreshToken = json['refreshToken'];
    expirationOfJwt = json['expirationOfJwt'];
    expirationOfRefreshToken = json['expirationOfRefreshToken'];
    success = json['success'];
    emailConfirmed = json['emailConfirmed'];
  }
}

class UserData
{
  late String name;
  late String email;
  late String role;

  // named constructor
  UserData.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    role = json['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
  }
}