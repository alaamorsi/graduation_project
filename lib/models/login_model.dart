class LoginModel
{
  late bool status;
  late dynamic message;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['Status'];
    message = json['Message'];
    data = (json['Data'] != null ? UserData.fromJson(json['Data']) : null)!;
  }
}

class UserData
{
  late int id;
  late String firstName;
  late String lastName;
  late String image;
  late String email;
  late bool emailConfirmed;
  late String role;
  late String password;

  // named constructor
  UserData.fromJson(Map<String, dynamic> json)
  {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    image = json['Image'];
    email = json['Email'];
    role = json['Role'];
    emailConfirmed = json['EmailConfirmed'];
    password = json['Password'];
  }
}