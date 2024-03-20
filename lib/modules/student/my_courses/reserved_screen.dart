import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import 'screens/course_leader.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List <double> progress=[0,10,50];
    var theme= Theme.of(context);
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title:"Enrolled Courses".tr,
              hasActions: false,
            ),
            body: ConditionalBuilder(
              condition: myCourses.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: myCourses.length,
                    itemBuilder: (context ,index){
                      return paidCourse(
                          context: context,
                          course: myCourses[index],
                          theme: theme,
                          courseProgress: progress[index]
                      );
                    }
                ),
              ),
              fallback: (context) => Center(child: Text('You are not in class yet'.tr)),
            ),
          );
      }
    );
  }
  // paid course item
  Widget paidCourse({
    required BuildContext context,
    required MyCourse course,
    required ThemeData theme,
    bool isReserved =false,
    bool isFavourite = false,
    required double courseProgress,
  }) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: InkWell(
        onTap: (){navigateTo(context, ClassLeader(course: course,));},
        child: Container(
          width: screenWidth,
          height: screenHeight/7,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(.1),
            borderRadius: const BorderRadius.all(Radius.circular(23.0),),
          ),
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //Teacher image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: screenHeight/10,
                    height: screenHeight/10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: NetworkImage(course.teacherImage),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.subject.tr,
                      style: font.copyWith(fontSize: 18.0,color: theme.primaryColor),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      '${course.videosNumber}${'lessons'.tr}',
                      style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                    ),
                  ],
                ),
                const Spacer(),
                CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 6,
                  animation: true,
                  percent: courseProgress/100,
                  center: Text(
                    "$courseProgress%",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,color: theme.primaryColorDark),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: theme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<MyCourse> myCourses=[
  MyCourse(
    category: 1,
    teacherImage: 'https://media.istockphoto.com/id/869144556/photo/at-work.webp?s=2048x2048&w=is&k=20&c=A2UQ5503q2265YRRHnIKm7O1LlZKBZwX2iPH-PXpEQQ=',
    teacherName: 'محمود بدر',
    subject: 'Geography',
    eduLevel: 'ثالثة ثانوي',
    term: 2,
    year: 2023,
    videosNumber: 3,
    price: 300,
    review: [
      Review(rate: 5,name: "sameh Ahmed", dateTime: "2024-03-06", comment: "this course is awesome"),
      Review(rate: 5,name: "omer mohamed", dateTime: "2024-03-06", comment: "good course"),
      Review(rate: 5,name: "alaa morsi", dateTime: "2024-03-06", comment: "this course is awesome"),
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