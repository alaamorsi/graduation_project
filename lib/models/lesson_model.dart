class LessonModel {
  late String lessonName;
  late String period;
  late String videoUrl;

  LessonModel.fromJson(Map<String, dynamic> json) {
    lessonName = json["lessonName"]??'';
    period = json["period"]??'';
    videoUrl = json["videoUrl"]??'';
  }
}