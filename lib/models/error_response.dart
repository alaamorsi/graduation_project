class RegisterResponse
{
  late bool success;
  late bool hasRepeatedEmail;
  late bool hasRepeatedUserName;

  RegisterResponse.fromJson(Map<String, dynamic> json)
  {
    success = json['success'];
    hasRepeatedEmail = json['hasRepeatedEmail'];
    hasRepeatedUserName = json['hasRepeatedUserName'];
  }
}