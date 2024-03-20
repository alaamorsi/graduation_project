import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/tutor/home/add_course2.dart';
import '../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/component/components.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    List<String> subjects=[
      'Arabic',
      'English',
      'Mathematics',
      'Studies',
      'Science',
      'French',
      'Italian',
      'German',
      'History',
      'geography',
      'Chemistry',
      'Physics',
      'Biology',
      'Psychology',
      'Philosophy'
    ];
    List<String> eduLevel=[
      'First Primary',
      'Second  Primary',
      'Third  Primary',
      'Fourth Primary',
      'Fifth Primary',
      'Sixth Primary',
      'First Intermediate',
      'Second  Intermediate',
      'Third  Intermediate',
      'First Secondary',
      'Second  Secondary',
      'Third  Secondary',
    ];
    List<String> term=[
      'First Term',
      'Second Term',
    ];

    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(
            context: context,
            title: "Add Course",
            hasAction: true,
            actionIcon: InkWell(
              onTap: (){
                navigateTo(context, const AddCourse2());
              },
              child: Padding(padding: const EdgeInsets.only(right:10.0),
                child:Container(
                  height: 43,
                  padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: Text("Next",style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),)
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                Text(
                  "Course Type",
                  style: font.copyWith(color: theme.primaryColorDark,fontWeight: FontWeight.bold,fontSize: 20),
                ),
                const SizedBox(height: 10,),
                //type selections
                Wrap(
                  spacing: 10,
                  children: [
                    //live selection
                    InkWell(
                      onTap: (){
                        cubit.changeCourseTypeSelection(0);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: screenWidth/2-25,
                        decoration: BoxDecoration(
                          color: cubit.courseTypeSel[0]?theme.canvasColor:theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color:theme.primaryColorDark,width: .5),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                height: 90,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Image(image: AssetImage("Assets/for_teacher/live.png")),
                              ),
                              const SizedBox(height: 10.0),
                              Text("Live Course",
                                style: font.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //recorded selection
                    InkWell(
                      onTap: (){
                        cubit.changeCourseTypeSelection(1);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: screenWidth/2-25,
                        decoration: BoxDecoration(
                          color: cubit.courseTypeSel[1]?theme.canvasColor:theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color:theme.primaryColorDark,width: .5),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                height: 90,
                                decoration:const BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: const Image(image: AssetImage("Assets/for_teacher/recorded.png")),
                              ),
                              const SizedBox(height: 10.0),
                              Text("Recorded",
                                style: font.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                  "Subject",
                  style: font.copyWith(color: theme.primaryColorDark,fontWeight: FontWeight.bold,fontSize: 20),
                ),
                const SizedBox(height: 10,),
                selectionField(
                    hint: 'choose subject',
                    list: subjects,
                    theme: theme,
                    onTap: (s){cubit.addNewCourseSelection(cubit.newCourseSub,s!);}
                ),
                const SizedBox(height: 20,),
                Text(
                  "Educational level",
                  style: font.copyWith(color: theme.primaryColorDark,fontWeight: FontWeight.bold,fontSize: 20),
                ),
                const SizedBox(height: 10,),
                selectionField(
                    hint: 'choose Educational level',
                    list: eduLevel,
                    theme: theme,
                    onTap: (s){cubit.addNewCourseSelection(cubit.newCourseEduLevel,s!);}
                ),
                const SizedBox(height: 20,),
                Text(
                  "Term",
                  style: font.copyWith(color: theme.primaryColorDark,fontWeight: FontWeight.bold,fontSize: 20),
                ),
                const SizedBox(height: 10,),
                selectionField(
                    hint: 'choose term (leave empty if level is third  secondary)',
                    list: term,
                    theme: theme,
                    onTap: (s){cubit.addNewCourseSelection(cubit.newCourseTerm,s!);}
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget selectionField({
  required List<String> list,
  required String hint,
  required ThemeData theme,
  required  void Function(String? value) onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: DropdownMenu<String>(
      width: screenWidth-60,
      hintText: hint,
      dropdownMenuEntries: list.map((e) => DropdownMenuEntry<String>(value: e,label: e,)).toList(),
      onSelected: onTap,
      menuStyle: MenuStyle(
        backgroundColor:MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
        side: MaterialStatePropertyAll(BorderSide(color: theme.primaryColorDark)),
      ),
    ),
  );
}
