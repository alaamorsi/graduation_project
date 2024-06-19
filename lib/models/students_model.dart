class StudentModel{
  late int id;
  late String name;
  late String image;

  StudentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["profilePicture"]??'';
  }
}