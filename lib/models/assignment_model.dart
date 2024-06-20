class AssignmentModel {
  late int id;
  late String description;
  late int grade;
  late String deadLine;
  late String file;

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]??1;
    description = json["description"]??'';
    grade = json["grade"]??10;
    deadLine = json["deadLine"]??'';
    file = json["file"]??'';
  }
}