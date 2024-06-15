class StudentModel{
  late String name;
  late String image;

  StudentModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"]??'';
  }
}