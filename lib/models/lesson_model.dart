class LessonModel {
  late String name;
  late String period;
  late String video;

  LessonModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    period = json["period"];
    video = json["video"];
  }
}