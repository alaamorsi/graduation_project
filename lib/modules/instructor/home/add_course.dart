import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/instructor/instructor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/instructor/instructor_cubit/instructor_states.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/component/components.dart';

class AddCourse extends StatelessWidget {
  const AddCourse({super.key});

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
    List<String> courseTypeTitle=['Live Course','Recorded'];
    List<String> courseTypeSubTitle=[
      'Encourages students to self-discipline and regularity',
      'Students can continue their studies at any time'
    ];
    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = InstructorCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: "Add New Course"),
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
                          color: cubit.courseTypeSel[0]?theme.cardColor:theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color:theme.primaryColorDark,width: .5),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //teacher name
                              Text(courseTypeTitle[0],
                                style: font.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                              ),
                              const SizedBox(height: 5,),
                              Text(courseTypeSubTitle[0],
                                style: font.copyWith(fontSize: 14.0,color: theme.primaryColorDark.withOpacity(.5)),
                                maxLines: 4,),
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
                          color: cubit.courseTypeSel[1]?theme.cardColor:theme.scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color:theme.primaryColorDark,width: .5),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //teacher name
                              Text(courseTypeTitle[1],
                                style: font.copyWith(fontSize: 20.0, fontWeight: FontWeight.bold,color: theme.primaryColorDark),
                              ),
                              const SizedBox(height: 5,),
                              Text(courseTypeSubTitle[1],
                                style: font.copyWith(fontSize: 14.0,color: theme.primaryColorDark.withOpacity(.5)),
                                maxLines: 4,),
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
                const SizedBox(height: 10,),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    color: theme.primaryColorLight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5,top: 10,right: 130
                    ),
                    child: usedButton(
                      atEnd: false,
                      text: "Next",
                      color: theme.cardColor,
                      radius: 10,
                      paddingSize: 10,
                      context: context,
                      onPressed:(){
                      },
                    ),
                  ),
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
      initialSelection: hint,
      dropdownMenuEntries: list.map((e) => DropdownMenuEntry<String>(value: e,label: e,)).toList(),
      onSelected: onTap,
      menuStyle: MenuStyle(
        backgroundColor:MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
        side: MaterialStatePropertyAll(BorderSide(color: theme.primaryColorDark)),
      ),
    ),
  );
}
