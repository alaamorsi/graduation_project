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
  late double? grade;
  late int maxGrade;
  late String solutionUrl;

  SolutionModel.fromJson(Map<String, dynamic> json) {
    studentId = json["studentId"];
    fullName = json["fullName"]??'';
    description = json["description"]??'';
    grade = json["grade"];
    maxGrade = json["maxGrade"]??10;
    solutionUrl = json["solutionUrl"]??'';
  }
}

class GradeModel {
  late double? grade;
  late int maxGrade;

  GradeModel.fromJson(Map<String, dynamic> json) {
    grade = json["grade"]??0.0;
    maxGrade = json["maxGrade"]??10;
  }
}