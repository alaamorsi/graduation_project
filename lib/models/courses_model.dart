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
    favourite = json["favourite"] ?? false;
    isPublished = json["isPublish"] ?? false;
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
    isPublished = json["isPublish"] ?? false;
  }
}

class CourseDetailsModel {
  late String instructorName;
  late String academicLevel;
  late String lessonName;
  late String url;
  late String period;
  late String courseDescription;

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    instructorName = json['instructorName'] ?? '';
    academicLevel = json['academicLevel'] ?? '';
    lessonName = json['lessonName'] ?? '';
    url = json['url'] ?? '';
    period = json['period'] ?? '';
    courseDescription = json['courseDescription'] ?? '';
  }

  CourseDetailsModel(
      {
      required this.instructorName,
      required this.academicLevel,
      required this.lessonName,
      required this.url,
      required this.period,
      required this.courseDescription});
}
