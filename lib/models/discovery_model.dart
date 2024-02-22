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
    json['courses'].forEach((element)
    {
      courses.add(CourseModel.fromJson(element));
    });
  }
}

class CourseModel
{
  late int id;
  late String teacherImage;
  late String teacherName;
  late String type;
  late String subject;
  late String educationalLevel;
  late int term;
  late int lunchDate;
  late int videosNumbers;
  late int price;
  late bool inFavorite;
  late bool reserved;


  CourseModel.fromJson(Map<dynamic, dynamic> json)
  {
    id = json['Id'];
    teacherImage = json['TeacherImage'];
    teacherName = json['TeacherName'];
    type = json['Type'];
    subject = json['Subject'];
    educationalLevel = json['EducationalLevel'];
    term = json['Term'];
    lunchDate = json['LunchDate'];
    videosNumbers = json['VideosNumbers'];
    price = json['Price'];
    inFavorite = json['InFavorite'];
    reserved = json['reserved'];
  }
}