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
class SolutionModel {
  late int studentId;
  late String fullName;
  late String description;
  late String solutionUrl;

  SolutionModel.fromJson(Map<String, dynamic> json) {
    studentId = json["studentId"];
    fullName = json["fullName"]??'';
    description = json["description"]??'';
    solutionUrl = json["solutionUrl"]??'';
  }
}