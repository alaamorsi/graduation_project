class Course {
  final int category;
  final String teacherName;
  final String teacherImage;
  final String subject;
  final String eduLevel;
  final int term;
  final int year;
  final int videosNumber;

  Course({
    required this.category,
    required this.teacherImage,
    required this.teacherName,
    required this.subject,
    required this.eduLevel,
    required this.term,
    required this.year,
    required this.videosNumber,
});

}

List<Course> courses=[
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/869144556/photo/at-work.webp?s=2048x2048&w=is&k=20&c=A2UQ5503q2265YRRHnIKm7O1LlZKBZwX2iPH-PXpEQQ=',
      teacherName: 'محمود بدر',
      subject: 'عربي',
      eduLevel: 'ثالثة ثانوي',
      term: 2,
      year: 2023,
      videosNumber: 28,
  ),
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/1468138682/photo/happy-elementary-teacher-in-front-of-his-students-in-the-classroom.jpg?s=2048x2048&w=is&k=20&c=t4IHUSfyRczWv7Fm6eh0Qxfs5u805cNSyVc3PSxsdMY=',
      teacherName: 'محمد المهندس',
      subject: 'كيمياء',
      eduLevel: 'ثالثة اعدادي',
      term: 2,
      year: 2023,
      videosNumber: 17,
  ),
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/1410764326/photo/portrait-of-happy-successful-businessman-satisfied-man-feeling-confident-in-a-creative-office.jpg?s=2048x2048&w=is&k=20&c=BDFYJLWB4mjjXbMYZ0Oz-w12a-yXP5qRVAwzdEcRhZE=',
      teacherName: 'احمد الاسيوطي',
      subject: 'فرنساوي',
      eduLevel: 'ثانية ثانوي',
      term: 2,
      year: 2023,
      videosNumber: 16,
  ),
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/1392124785/photo/happy-elementary-teacher-in-the-classroom.jpg?s=2048x2048&w=is&k=20&c=XpYVtNLdjLCOcbnCRVi_PJN42T40lPO9zSbJASGVg8k=',
      teacherName: 'كامل المهدي',
      subject: 'فزياء',
      eduLevel: 'اولي ثانوي',
      term: 2,
      year: 2023,
      videosNumber: 28,
  ),
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/1160926571/photo/portrait-of-male-elementary-school-teacher-standing-in-classroom.jpg?s=2048x2048&w=is&k=20&c=vviOvXdZnkq9uc1GT7bXrNj43x3EUelKpQlgMxMIBhg=',
      teacherName: 'معتز ابراهيم',
      subject: 'رياضيات',
      eduLevel: 'ثالثة ثانوي',
      term: 1,
      year: 2024,
      videosNumber: 33,
  ),
  Course(
      category: 1,
      teacherImage: 'https://media.istockphoto.com/id/1384332905/photo/beautiful-woman.jpg?s=2048x2048&w=is&k=20&c=b8wYz2v_uyqtn3FyNp9E-awHqZfK9nRlzHRKnLoG0rc=',
      teacherName: 'نسرين مصطفي',
      subject: 'انجليزي',
      eduLevel: 'تانية اعدادي',
      term: 2,
      year: 2023,
      videosNumber: 18,
  ),

];