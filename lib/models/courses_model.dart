class CourseModel {
  late int courseId;
  late String? instProfilePicture;
  late String subject;
  late int lessonsNumber;
  late int price;
  late double rate;
  late bool favourite;
  late bool isPublished;

  CourseModel.fromJson(Map<String, dynamic> json) {
    courseId = json["courseId"] ?? 0;
    instProfilePicture = json["instProfilePicture"] ?? '';
    rate = json["rate"] ?? 0;
    subject = json["subject"] ?? '';
    lessonsNumber = json["lessonsNumber"] ?? 0;
    price = json["price"] ?? 0;
    favourite = json["isFavourite"] ?? false;
    isPublished = json["isPublished"] ?? false;
  }
}

class InstructorCourseModel {
  late int courseId;
  late String courseName;
  late double averageRate;
  late int studentCount;
  late bool isPublished;

  InstructorCourseModel.fromJson(Map<String, dynamic> json) {
    courseName = json["courseName"] ?? '';
    averageRate = json["averageRate"] ?? 0;
    studentCount = json["studentCount"] ?? 0;
    courseId = json["id"];
    isPublished = json["isPublished"] ?? false;
  }
}
