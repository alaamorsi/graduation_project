import 'package:flutter/material.dart';

class Course {
  final int category;
  final String teacherName;
  final String teacherImage;
  final String subject;
  final String eduLevel;
  final int term;
  final int year;
  final int videosNumber;
  final int price;
  final List<Review> review;
  bool inFavourite;

  Course({
    required this.category,
    required this.teacherImage,
    required this.teacherName,
    required this.subject,
    required this.eduLevel,
    required this.term,
    required this.year,
    required this.videosNumber,
    required this.price,
    required this.review,
    required this.inFavourite,
  });
}

class Review {
  final String name;
  final int rate;
  String? image;
  final String dateTime;
  final String comment;

  Review({
    required this.name,
    required this.dateTime,
    required this.comment,
    required this.rate,
  });
}

List<Course> courses = [
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/869144556/photo/at-work.webp?s=2048x2048&w=is&k=20&c=A2UQ5503q2265YRRHnIKm7O1LlZKBZwX2iPH-PXpEQQ=',
    teacherName: 'محمود بدر',
    subject: 'Geography',
    eduLevel: 'ثالثة ثانوي',
    term: 2,
    year: 2023,
    videosNumber: 28,
    price: 300,
    review: [
      Review(
          rate: 5,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 5,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 5,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/1468138682/photo/happy-elementary-teacher-in-front-of-his-students-in-the-classroom.jpg?s=2048x2048&w=is&k=20&c=t4IHUSfyRczWv7Fm6eh0Qxfs5u805cNSyVc3PSxsdMY=',
    teacherName: 'محمد المهندس',
    subject: 'Arabic',
    eduLevel: 'ثالثة اعدادي',
    term: 2,
    year: 2023,
    videosNumber: 17,
    price: 300,
    review: [
      Review(
          rate: 4,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 3,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 1,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/1410764326/photo/portrait-of-happy-successful-businessman-satisfied-man-feeling-confident-in-a-creative-office.jpg?s=2048x2048&w=is&k=20&c=BDFYJLWB4mjjXbMYZ0Oz-w12a-yXP5qRVAwzdEcRhZE=',
    teacherName: 'احمد الاسيوطي',
    subject: 'Italian',
    eduLevel: 'ثانية ثانوي',
    term: 2,
    year: 2023,
    videosNumber: 16,
    price: 300,
    review: [
      Review(
          rate: 3,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 2,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 5,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/1392124785/photo/happy-elementary-teacher-in-the-classroom.jpg?s=2048x2048&w=is&k=20&c=XpYVtNLdjLCOcbnCRVi_PJN42T40lPO9zSbJASGVg8k=',
    teacherName: 'كامل المهدي',
    subject: 'Science',
    eduLevel: 'اولي ثانوي',
    term: 2,
    year: 2023,
    videosNumber: 28,
    price: 300,
    review: [
      Review(
          rate: 5,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 2,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 5,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/1160926571/photo/portrait-of-male-elementary-school-teacher-standing-in-classroom.jpg?s=2048x2048&w=is&k=20&c=vviOvXdZnkq9uc1GT7bXrNj43x3EUelKpQlgMxMIBhg=',
    teacherName: 'معتز ابراهيم',
    subject: 'Mathematics',
    eduLevel: 'ثالثة ثانوي',
    term: 1,
    year: 2024,
    videosNumber: 33,
    price: 300,
    review: [
      Review(
          rate: 1,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 0,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 2,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
  Course(
    category: 1,
    teacherImage:
        'https://media.istockphoto.com/id/1384332905/photo/beautiful-woman.jpg?s=2048x2048&w=is&k=20&c=b8wYz2v_uyqtn3FyNp9E-awHqZfK9nRlzHRKnLoG0rc=',
    teacherName: 'نسرين مصطفي',
    subject: 'English',
    eduLevel: 'تانية اعدادي',
    term: 2,
    year: 2023,
    videosNumber: 18,
    price: 300,
    review: [
      Review(
          rate: 5,
          name: "sameh Ahmed",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
      Review(
          rate: 5,
          name: "omer mohamed",
          dateTime: "2024-03-06",
          comment: "good course"),
      Review(
          rate: 5,
          name: "alaa morsi",
          dateTime: "2024-03-06",
          comment: "this course is awesome"),
    ],
    inFavourite: false,
  ),
];

class MyCourse {
  final int category;
  final String teacherName;
  final String teacherImage;
  final String subject;
  final String eduLevel;
  final int term;
  final int year;
  final int videosNumber;
  final List<Lesson> lessons;
  final int price;
  final List<Review> review;
  bool inFavourite;

  MyCourse({
    required this.category,
    required this.teacherImage,
    required this.teacherName,
    required this.subject,
    required this.eduLevel,
    required this.term,
    required this.year,
    required this.videosNumber,
    required this.price,
    required this.review,
    required this.inFavourite,
    required this.lessons,
  });
}

class Lesson {
  final String lessonName;
  final double lessonTime;
  final String videoUrl;
  String? image;

  Lesson({
    required this.lessonName,
    required this.videoUrl,
    required this.lessonTime,
    this.image,
  });
}
List<Lesson> lessons=[
    Lesson(
        lessonName: "hello world",
        videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        image: 'https://media.istockphoto.com/id/1478239832/photo/bee-on-coneflower.jpg?s=1024x1024&w=is&k=20&c=yXYXo6SbCnYWHsY7j9JE9mvn7C7GHLbL2qaIVEskeec=',
        lessonTime: 3.24),
    Lesson(
        lessonName: "second lesson",
        videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        image: 'https://media.istockphoto.com/id/669593632/vector/moon-bunny.jpg?s=1024x1024&w=is&k=20&c=8Dz2T-bIH1T2D_6G-U7-CgWysiFCfsut-iueRy7BPeA=',
        lessonTime: 9.22),
    Lesson(
        lessonName: "test test",
        videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        image: 'https://media.istockphoto.com/id/455450437/vector/crazy-asian-with-astro-gun.jpg?s=1024x1024&w=is&k=20&c=nIE9OmmKmnAfCmCynfukea2mzEggicmXtoZqYGEjHWk=',
        lessonTime: 10),
  ];

List<MyCourse> myCourses=[
  MyCourse(
    category: 1,
    teacherImage: 'https://media.istockphoto.com/id/869144556/photo/at-work.webp?s=2048x2048&w=is&k=20&c=A2UQ5503q2265YRRHnIKm7O1LlZKBZwX2iPH-PXpEQQ=',
    teacherName: 'sameh Ahmed',
    subject: 'English',
    eduLevel: 'ثالثة ثانوي',
    term: 2,
    year: 2023,
    videosNumber: 2,
    price: 200,
    review: [
      Review(rate: 5,name: "alaa Ahmed", dateTime: "2024-03-06", comment: "this course is awesome"),
      Review(rate: 5,name: "omer mohamed", dateTime: "2024-03-06", comment: "good course"),
      Review(rate: 5,name: "alaa morsi", dateTime: "2024-03-06", comment: "this course is awesome"),
    ],
    inFavourite: false,
    lessons: [
      Lesson(
          lessonName: "intro",
          videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
          image: 'https://media.istockphoto.com/id/1478239832/photo/bee-on-coneflower.jpg?s=1024x1024&w=is&k=20&c=yXYXo6SbCnYWHsY7j9JE9mvn7C7GHLbL2qaIVEskeec=',
          lessonTime: 3.24),
      Lesson(
          lessonName: "second lesson",
          videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          image: 'https://media.istockphoto.com/id/669593632/vector/moon-bunny.jpg?s=1024x1024&w=is&k=20&c=8Dz2T-bIH1T2D_6G-U7-CgWysiFCfsut-iueRy7BPeA=',
          lessonTime: 9.22),
    ],
  ),
  MyCourse(
    category: 1,
    teacherImage: 'https://media.istockphoto.com/id/1468138682/photo/happy-elementary-teacher-in-front-of-his-students-in-the-classroom.jpg?s=2048x2048&w=is&k=20&c=t4IHUSfyRczWv7Fm6eh0Qxfs5u805cNSyVc3PSxsdMY=',
    teacherName: 'محمد المهندس',
    subject: 'Arabic',
    eduLevel: 'ثالثة اعدادي',
    term: 2,
    year: 2023,
    videosNumber: 2,
    price: 300,
    review: [
      Review(rate: 4,name: "sameh Ahmed", dateTime: "2024-03-06", comment: "this course is awesome"),
      Review(rate: 3,name: "omer mohamed", dateTime: "2024-03-06", comment: "good course"),
      Review(rate: 1,name: "alaa morsi", dateTime: "2024-03-06", comment: "this course is awesome"),
    ],
    inFavourite: false,
    lessons: [
      Lesson(
          lessonName: "hello world",
          videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
          image: 'https://media.istockphoto.com/id/1478239832/photo/bee-on-coneflower.jpg?s=1024x1024&w=is&k=20&c=yXYXo6SbCnYWHsY7j9JE9mvn7C7GHLbL2qaIVEskeec=',
          lessonTime: 3.24),
      Lesson(
          lessonName: "second lesson",
          videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          image: 'https://media.istockphoto.com/id/669593632/vector/moon-bunny.jpg?s=1024x1024&w=is&k=20&c=8Dz2T-bIH1T2D_6G-U7-CgWysiFCfsut-iueRy7BPeA=',
          lessonTime: 9.22),
    ],
  ),
  MyCourse(
    category: 1,
    teacherImage: 'https://media.istockphoto.com/id/1160926571/photo/portrait-of-male-elementary-school-teacher-standing-in-classroom.jpg?s=2048x2048&w=is&k=20&c=vviOvXdZnkq9uc1GT7bXrNj43x3EUelKpQlgMxMIBhg=',
    teacherName: 'معتز ابراهيم',
    subject: 'Mathematics',
    eduLevel: 'ثالثة ثانوي',
    term: 1,
    year: 2024,
    videosNumber: 3,
    price: 300,
    review: [
      Review(rate: 1,name: "sameh Ahmed", dateTime: "2024-03-06", comment: "this course is awesome"),
      Review(rate: 0,name: "omer mohamed", dateTime: "2024-03-06", comment: "good course"),
      Review(rate: 2,name: "alaa morsi", dateTime: "2024-03-06", comment: "this course is awesome"),
    ],
    inFavourite: false,
    lessons: [
      Lesson(
          lessonName: "hello world",
          videoUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
          image: 'https://media.istockphoto.com/id/1478239832/photo/bee-on-coneflower.jpg?s=1024x1024&w=is&k=20&c=yXYXo6SbCnYWHsY7j9JE9mvn7C7GHLbL2qaIVEskeec=',
          lessonTime: 3.24),
      Lesson(
          lessonName: "second lesson",
          videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
          image: 'https://media.istockphoto.com/id/669593632/vector/moon-bunny.jpg?s=1024x1024&w=is&k=20&c=8Dz2T-bIH1T2D_6G-U7-CgWysiFCfsut-iueRy7BPeA=',
          lessonTime: 9.22),
      Lesson(
          lessonName: "test test",
          videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
          image: 'https://media.istockphoto.com/id/455450437/vector/crazy-asian-with-astro-gun.jpg?s=1024x1024&w=is&k=20&c=nIE9OmmKmnAfCmCynfukea2mzEggicmXtoZqYGEjHWk=',
          lessonTime: 10),
    ],
  ),
];


class Message {
  final String senderFirstName;
  final String senderLastName;
  ImageProvider<Object>? senderProfileImage;
  final String messageContent;
  final String messageDate;

  Message({required this.senderFirstName, required this.senderLastName, required this.messageContent, required this.messageDate,this.senderProfileImage});
}

