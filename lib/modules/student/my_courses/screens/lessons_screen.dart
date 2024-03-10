import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/component/constant.dart';
import '../../../../shared/component/test.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CourseCubit.get(context).initializeFlickManager(CourseCubit.get(context).openedCourse.lessons[CourseCubit.get(context).currentVideoIndex].videoUrl);
    var theme = Theme.of(context);
    return BlocConsumer<CourseCubit,CourseStates>(
        listener: (context,state) {},
        builder:(context,state){
        var course = CourseCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            toolbarHeight: 70.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(11.0),
                bottomRight: Radius.circular(11.0),
              ),
            ),
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
            titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
            leading:Padding(
              padding: const EdgeInsets.only(
                  left: 14.0,top: 14.0,bottom: 14.0
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                ),
                child: IconButton(
                  onPressed: (){
                    course.disposeVideo();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,size: 20,color: Theme.of(context).primaryColor,),
                ),
              ),
            ),
            title: const Text("Lessons"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlickVideoPlayer(flickManager: course.flickManager),
                const SizedBox(height: 20,),
                Text('Next Lesson',style: font.copyWith(color: theme.primaryColorDark.withOpacity(.6),fontSize: 16.0,fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index)=>
                        buildLessonItem(
                          context: context,
                          index: index,
                          course: course.openedCourse,
                          theme: theme,
                          playedIndex : course.currentVideoIndex,
                          onTap: () {
                            course.playWithName(index,course.openedCourse.lessons[index].videoUrl);
                          },
                        ),
                    separatorBuilder: (BuildContext context, int index)=>const SizedBox(height: 20,),
                    itemCount: course.openedCourse.videosNumber,),
                )
              ],
            ),
          ),
    );
        }
        );
  }

  Widget buildLessonItem({
    required BuildContext context,
    required int index,
    required int playedIndex,
    required MyCourse course,
    required ThemeData theme,
    required void Function() onTap,
  })
  {
    int munit = course.lessons[index].lessonTime.toInt();
    double second = (course.lessons[index].lessonTime % 1)*60;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth,
        height: screenHeight/8,
        decoration: BoxDecoration(
          color: theme.primaryColorLight.withOpacity(.3),
          borderRadius: const BorderRadius.all(Radius.circular(23.0),),
        ),
        child:Row(
          children: [
            //Teacher image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: screenHeight/10,
                height: screenHeight/10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image:  NetworkImage(course.lessons[index].image!),
                    fit: BoxFit.cover,),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Expanded(
                  child: Text(course.lessons[index].lessonName,
                    style: font.copyWith(fontSize: 16.0,color: theme.primaryColorDark),
                  ),
                ),
                const SizedBox(height: 5,),
                Expanded(
                  child: Text("$munit m ${second.toInt()} s",
                    style: font.copyWith(fontSize: 12.0,color: theme.primaryColorDark.withOpacity(.5)),
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: index==playedIndex?
                  Icon( Icons.play_circle,color: theme.primaryColor,size: 33,):
                  const Icon(Icons.play_circle_outline,color: Colors.grey,size: 30,),
                ),
              ],
            ),
            const SizedBox(width: 15,),
          ],
        ),
      ),
    );
  }
}
