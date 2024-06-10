class DiscoveryModel
{
  late bool status;
  late CourseDataModel data;

  DiscoveryModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CourseDataModel.fromJson(json['data']);
  }
}

class CourseDataModel
{
  List<CourseModel> courses = [];

  CourseDataModel.fromJson(Map<String, dynamic> json)
  {
    json['data'].forEach((element)
    {
      courses.add(CourseModel.fromJson(element));
    });
  }
}

class CourseModel
{
  late int courseId;
  late String? instProfilePicture;
  late String subject;
  late int lessonsNumber;
  late int price;
  late double rate;
  late bool isFavourite;

  CourseModel(
      this.courseId,
      this.instProfilePicture,
      this.subject,
      this.lessonsNumber,
      this.price,
      this.rate,
      this.isFavourite
      );

  CourseModel.fromJson(Map<dynamic, dynamic> json)
  {
    courseId = json['courseId'];
    instProfilePicture = json['instProfilePicture'];
    rate = json['rate'];
    subject = json['subject'];
    lessonsNumber = json['lessonsNumber'];
    price = json['price'];
    isFavourite = json['isFavourite'];
  }
}