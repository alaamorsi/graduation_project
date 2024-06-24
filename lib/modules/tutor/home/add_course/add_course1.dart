import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/constant.dart';
import '../../../../shared/component/components.dart';

class AddCourse extends StatefulWidget {
  final String courseType;

  const AddCourse({
    super.key,
    required this.courseType,
  });

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      await InstructorCubit.get(context).onPaymentComplete();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocConsumer<InstructorCubit, InstructorStates>(
      listener: (context, state) {
        if (state is PaymentManagerSuccessState) {
          showToast(
              title: "Course Addition",
              description: "Course has been added successfully",
              state: MotionState.success,
              context: context);
          Get.back();
        } else if (state is PaymentManagerErrorState) {
          showToast(
              title: "Course Addition",
              description: "Sorry, something went wrong during payment process",
              state: MotionState.error,
              context: context);
        }
      },
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
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child: ListView(
                children: [
                  Text(
                    "Stage".tr,
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
                      hint: 'choose stage'.tr,
                      list: stage,
                      theme: theme,
                      onSelect: (s) {
                        cubit.stageSelect(s!);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Level".tr,
                    style: font.copyWith(
                        color: theme.primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  selectionFieldDependOnOther(
                      context: context,
                      hint: 'choose Educational level'.tr,
                      dependentSelection: cubit.courseStage,
                      list: eduLevel,
                      theme: theme,
                      onSelect: (s) {
                        cubit.levelSelect(s!);
                      },
                  ),
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
                      onSelect: (s) {
                        cubit.termSelect(s!);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
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
                  selectionFieldDependOnOther(
                      context: context,
                      hint: 'choose subject'.tr,
                      dependentSelection: cubit.courseStage,
                      list: subjects,
                      theme: theme,
                      onSelect: (s) {
                        cubit.subjectSelect(s!);
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      textAlign: TextAlign.start,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter course price!'.tr;
                        }
                        return null;
                      },
                      style: const TextStyle(
                          color: Colors.black87, fontSize: 16.0),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0),
                        hintText: 'Ex: 200 EGP'.tr,
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 13.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: theme.primaryColorDark, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: theme.primaryColorDark,
                            width: .8,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: theme.primaryColorDark,
                            width: .8,
                          ),
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
                          'Note : Service fee is 30 EPG for each course you make to ensure your seriously and will get back after 100 subscriptions,Also after make the course for every student who buy your course application will get 15% of subscription.'
                              .tr,
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
                        if (formKey.currentState!.validate()) {
                          cubit.payManager(
                            30,
                            'addCourse,${CacheHelper.getData(key: 'id')},${widget.courseType},${cubit.courseSub},${cubit.courseLevel},${cubit.courseStage},${cubit.courseTerm},${priceController.text}',
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 2.0,
                        shadowColor: Colors.white,
                        backgroundColor: theme.cardColor,
                        padding: const EdgeInsets.all(10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is PaymentManagerLoadingState
                              ? const Center(child: CircularProgressIndicator())
                              : Text(
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
  required void Function(String?)? onSelect,
  required context,
}) {
  return PopScope(
    onPopInvoked: (bool back) async {
      InstructorCubit.get(context).isBack();
    },
    canPop: InstructorCubit.get(context).back,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: DropdownMenu<String>(
        menuHeight: screenHeight * 0.2,
        width: screenWidth * 0.94,
        hintText: hint,
        textStyle: font.copyWith(color: theme.primaryColorDark, fontSize: 18.0),
        dropdownMenuEntries: list
            .map((e) => DropdownMenuEntry<String>(
                value: e,
                label: e.tr,
                labelWidget: Text(
                  e.tr,
                  style: font.copyWith(
                      color: theme.primaryColorDark,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                )))
            .toList(),
        onSelected: onSelect,
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

Widget selectionFieldDependOnOther({
  required List<String> list,
  required String hint,
  required ThemeData theme,
  required String dependentSelection,
  required void Function(String?)? onSelect,
  required context,
}) {
  return PopScope(
    onPopInvoked: (bool back) async {
      InstructorCubit.get(context).isBack();
    },
    canPop: InstructorCubit.get(context).back,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      child: DropdownMenu<String>(
        menuHeight: screenHeight * 0.2,
        width: screenWidth * 0.94,
        hintText: hint,
        textStyle: font.copyWith(color: theme.primaryColorDark, fontSize: 18.0),
        dropdownMenuEntries: dropdownMenuEntriesWithSelection(
            theme: theme, list: list, dependentSelection: dependentSelection),
        onSelected: onSelect,
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

List<DropdownMenuEntry<String>> dropdownMenuEntriesWithSelection({
  required ThemeData theme,
  required List<String> list,
  required String dependentSelection,
}) {
  if(list == eduLevel){
    if (dependentSelection == 'PrimaryStage') {
      return list
          .map((e) => DropdownMenuEntry<String>(
          value: e,
          label: e.tr,
          labelWidget: Text(
            e.tr,
            style: font.copyWith(
                color: theme.primaryColorDark,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )))
          .toList();
    } else {
      //اعدادي وثانوي
      List<String> newList  = [
        'FirstYear',
        'SecondYear',
        'ThirdYear'
      ];
      return newList
          .map((e) => DropdownMenuEntry<String>(
          value: e,
          label: e.tr,
          labelWidget: Text(
            e.tr,
            style: font.copyWith(
                color: theme.primaryColorDark,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )))
          .toList();
    }
  }
  else{
    if (dependentSelection == 'PrimaryStage') {
      List<String> newList =[
        'Arabic',
        'English',
        'Maths',
        'Sciences',
        'SocialStudies',
      ];
      return newList
          .map((e) => DropdownMenuEntry<String>(
          value: e,
          label: e.tr,
          labelWidget: Text(
            e.tr,
            style: font.copyWith(
                color: theme.primaryColorDark,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )))
          .toList();
    }
    else if (dependentSelection == 'PreparatoryStage') {
      List<String> newList =[
        'Arabic',
        'English',
        'Maths',
        'Sciences',
        'SocialStudies',
        'German',
        'Spanish',
        'Italian',
        'French',
        'History',
        'Geography',
        'Chemistry',
        'Physics',
      ];
      return newList
          .map((e) => DropdownMenuEntry<String>(
          value: e,
          label: e.tr,
          labelWidget: Text(
            e.tr,
            style: font.copyWith(
                color: theme.primaryColorDark,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )))
          .toList();
    } else {
      List<String> newList =[
        'Arabic',
        'English',
        'Maths',
        'German',
        'Spanish',
        'Italian',
        'French',
        'History',
        'Geography',
        'Chemistry',
        'Physics',
        'Philosophy',
        'Psychology',
        'Biology',
        'Geology',
        'Economics',
        'Statistics',
      ];
      return newList
          .map((e) => DropdownMenuEntry<String>(
          value: e,
          label: e.tr,
          labelWidget: Text(
            e.tr,
            style: font.copyWith(
                color: theme.primaryColorDark,
                fontSize: 17.0,
                fontWeight: FontWeight.bold),
          )))
          .toList();
    }
  }
}
