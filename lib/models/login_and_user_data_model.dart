class LoginModel
{
  late String? jwt;
  late String? profilePicture;
  late String? refreshToken;
  late String? expirationData;
  late String? expirationOfRefreshToken;
  late bool success;
  late bool emailConfirmed;
  late String? biography;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    jwt = json['jwt'];
    profilePicture = json['profilePicture'];
    refreshToken = json['refreshToken'];
    expirationData = json['expirationOfJwt'];
    expirationOfRefreshToken = json['expirationOfRefreshToken'];
    success = json['success'];
    emailConfirmed = json['emailConfirmed'];
    biography = json['biography'];
  }
}
class UserData
{
  late String firstName;
  late String lastName;
  late String email;
  late String role;
  late String id;
  late String userName;

  UserData.fromJson(Map<String, dynamic> json)
  {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    id = json['id'];
    userName = json['userName'];
  }
}