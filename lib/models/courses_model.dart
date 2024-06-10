class CourseModel
{
  late int courseId;
  late String? instProfilePicture;
  late String subject;
  late int lessonsNumber;
  late int price;
  late double rate;
  late bool isFavourite;

  CourseModel({
      required this.courseId,
      required this.instProfilePicture,
      required this.subject,
      required this.lessonsNumber,
      required this.price,
      required this.rate,
      required this.isFavourite
});

  factory CourseModel.fromJson(Map<String, dynamic> json){
    return CourseModel(
      courseId: json["courseId"],
      instProfilePicture: json["instProfilePicture"]??"",
      rate: json["rate"]??"",
      subject: json["subject"],
      lessonsNumber: json["lessonsNumber"],
      price: json["price"],
      isFavourite: json["isFavourite"],
    );
  }
}