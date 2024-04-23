import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/constant.dart';
import '../../../../shared/component/components.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({super.key});

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    List<String> subjects = [
      'Arabic',
      'English',
      'Mathematics',
      'Studies',
      'Science',
      'History',
      'Geography',
      'Chemistry',
      'Physics',
      'French',
      'Italian',
      'German',
      'Biology',
      'Geology',
      'Dynamics',
      'Statics',
      'Psychology',
      'Philosophy'
    ];
    List<String> eduLevel = [
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
    List<String> term = [
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
            title: "Course details".tr,
            hasAction: false,
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  Text(
                    "Subject".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectionField(
                      context: context,
                      hint: 'choose subject'.tr,
                      list: subjects,
                      theme: theme,
                      onTap: (s) {
                        cubit.addNewCourseSelection(cubit.newCourseSub, s!);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Educational level".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectionField(
                      context: context,
                      hint: 'choose Educational level'.tr,
                      list: eduLevel,
                      theme: theme,
                      onTap: (s) {
                        cubit.addNewCourseSelection(cubit.newCourseEduLevel, s!);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Term".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectionField(
                      context: context,
                      hint: 'choose term'.tr,
                      list: term,
                      theme: theme,
                      onTap: (s) {
                        cubit.addNewCourseSelection(cubit.newCourseTerm, s!);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Price".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Please enter course price!'.tr;
                        return null;
                      },
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0),
                        hintText: 'Ex: 200 EGP'.tr,
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54, width: 1.0,),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: Colors.black54, width: 1.0,),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info,
                          color: theme.primaryColor,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Text(
                          'Note : Service fee is 30 EPG for each course you make to ensure your seriously and will get back after 100 subscriptions,Also after make the course for every student who buy your course application will get 15% of subscription.'.tr,
                          style: font.copyWith(
                              color: theme.primaryColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if(formKey.currentState!.validate())
                            {
                              cubit.payManager(int.parse(priceController.text));
                            }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          shadowColor: Colors.white,
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Pay for the service fee'.tr,
                              style: font.copyWith(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
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
  required void Function(String? value) onTap,
  required context,
}) {
  return WillPopScope(
    onWillPop: () async {
      InstructorCubit.get(context).isBack();
      return false;
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownMenu<String>(
        menuHeight: 200,
        width: screenWidth - 60,
        hintText: hint,
        dropdownMenuEntries: list
            .map((e) => DropdownMenuEntry<String>(
                  value: e,
                  label: e.tr,
                ))
            .toList(),
        onSelected: onTap,
        menuStyle: MenuStyle(
          backgroundColor:
              MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
          side: MaterialStatePropertyAll(
              BorderSide(color: theme.primaryColorDark)),
        ),
      ),
    ),
  );
}

//                      InkWell(
//                         onTap: () {
//                           cubit.changeCourseTypeSelection(1);
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           width: screenWidth / 2 - 25,
//                           decoration: BoxDecoration(
//                             color: cubit.courseTypeSel[1]
//                                 ? theme.canvasColor
//                                 : theme.scaffoldBackgroundColor,
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(15.0)),
//                             border: Border.all(
//                                 color: theme.primaryColorDark, width: .5),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(11.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(15),
//                                   height: 90,
//                                   decoration: const BoxDecoration(
//                                     color: Colors.transparent,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Image(
//                                       image: AssetImage(
//                                           "Assets/for_teacher/recorded.png")),
//                                 ),
//                                 const SizedBox(height: 10.0),
//                                 Text(
//                                   "Recorded",
//                                   style: font.copyWith(
//                                       fontSize: 20.0,
//                                       fontWeight: FontWeight.bold,
//                                       color: theme.primaryColorDark),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       )