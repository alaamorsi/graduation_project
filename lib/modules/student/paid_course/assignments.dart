import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../shared/component/components.dart';

List<Question> questions=[
  Question(
      question: 'تعتبر حركة الكواكب حول الشمس حركة؟',
      isMultiChoose: true,
      answers: ['أ - حركة دورية','ب - حركة توافقية','ج - حركة اهتزازية','د - حركة دورانية'],
      correctAnswer: 1),
  Question(
      question: 'تكون طاقة حركة البندول أكبر عند مروره بموضع السكون؟',
      isMultiChoose: false,
      answers: ['أ - صح','ب - خظأ'],
      correctAnswer: 1),
  Question(
      question: 'تعتبر حركة الكواكب حول الشمس حركة؟',
      isMultiChoose: true,
      answers: ['أ - حركة دورية','ب - حركة توافقية','ج - حركة اهتزازية','د - حركة دورانية'],
      correctAnswer: 2),
  Question(
      question: 'تعتبر حركة الكواكب حول الشمس حركة؟',
      isMultiChoose: true,
      answers: ['أ - حركة دورية','ب - حركة توافقية','ج - حركة اهتزازية','د - حركة دورانية'],
      correctAnswer: 3),
  Question(
      question: 'تعتبر حركة الكواكب حول الشمس حركة؟',
      isMultiChoose: true,
      answers: ['أ - حركة دورية','ب - حركة توافقية','ج - حركة اهتزازية','د - حركة دورانية'],
      correctAnswer: 4),
  Question(
      question: 'تكون طاقة حركة البندول أكبر عند مروره بموضع السكون؟',
      isMultiChoose: false,
      answers: ['أ - صح','ب - خظأ'],
      correctAnswer: 1),
  Question(
      question: 'تكون طاقة حركة البندول أكبر عند مروره بموضع السكون؟',
      isMultiChoose: false,
      answers: ['أ - صح','ب - خظأ'],
      correctAnswer: 1),
];
late List<int> studentAnswers;
class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var cubit = StudentCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(
              context: context,
              title: "Assignments"),
          body: SingleChildScrollView(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: theme.primaryColor,
                    labelStyle: font.copyWith(color: theme.primaryColor,fontSize: 19.0),
                    unselectedLabelStyle: font.copyWith(color: Colors.grey,fontSize: 16.0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Lesson Test'),
                      Tab(text: 'Assignment'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 700,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Assignment 1",style: font.copyWith(
                                    color: Theme.of(context).cardColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                                  ),
                                  const Spacer(),
                                  Text("23 نوفمبر 11.59م",style: font.copyWith(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Text("In legal terms, an assignment refers to the transfer of a right or liability from one party to another. It can involve property, financial agreements, or other legal matters",
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                style: font.copyWith(
                                  color: Colors.black,
                                  fontSize: 16.0,),
                              ),
                              const SizedBox(height: 20.0),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Image(image: AssetImage('Assets/teacher.png'),fit: BoxFit.cover,)),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: usedButton(
                                  paddingSize: 10,
                                  radius: 5,
                                  atEnd: false,
                                  text: 'اضافة عمل',
                                  color: Theme.of(context).cardColor,
                                  context: context,
                                  onPressed:(){},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: usedButton(
                                  paddingSize: 10,
                                  radius: 5,
                                  atEnd: false,
                                  text: 'تسليم',
                                  color: Colors.black38,
                                  context: context,
                                  onPressed:(){},
                                ),
                              ),
                            ],
                          ),
                          //Test
                          ConditionalBuilder(
                            condition: false,
                            builder: (BuildContext context) =>
                                Column(
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context,index)=>questionItem(context, index, questions[index]),
                                    itemCount:questions.length,
                                  ),
                                ),
                                const SizedBox(height: 15.0),
                                usedButton(
                                  paddingSize: 10,
                                  radius: 5,
                                  atEnd: false,
                                  text: 'تسليم',
                                  color: Colors.black38,
                                  context: context,
                                  onPressed:(){},
                                ),
                              ],
                            ),
                            fallback: (BuildContext context) =>
                                Center(
                                  child:Text(
                                    "There is no Quiz's",
                                    style: font.copyWith(color: theme.primaryColor,fontSize: 19.0),
                                  ),
                                ),
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

  Widget questionItem(
      BuildContext context,
      int qNumber,
      Question question,)
  {
    List<bool> answered = List.filled(question.answers.length, false);
    return Card(
      color: Colors.white70,
      shadowColor: Colors.black87,
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            //question
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text('${qNumber+1}''س',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ],
            ),
            Text(question.question,
              textDirection: TextDirection.rtl,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: font.copyWith(
                  color: Theme.of(context).cardColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            ConditionalBuilder(
              condition: question.isMultiChoose,
              builder: (context)=>Wrap(
                children: [
                  chooseItem(context, question.answers[0], answered[0]),
                  chooseItem(context, question.answers[1], answered[1]),
                  chooseItem(context, question.answers[2], answered[2]),
                  chooseItem(context, question.answers[3], answered[3]),
                ],
              ),
              fallback: (context)=>Wrap(
                children: [
                  chooseItem(context, question.answers[0], answered[0]),
                  chooseItem(context, question.answers[1], answered[1]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseItem(BuildContext context,String answer,bool answered){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: FilterChip(
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),),
          label: Text(answer,style: font.copyWith(color: Colors.white,fontSize: 14.0),),
          selected: answered,
          backgroundColor: Colors.grey,
          selectedColor: Theme.of(context).cardColor,
          onSelected: (bool select){
            setState(() {
              answered = !answered;
            });
          }
      ),
    );
  }
}
class Question{
  late String question;
  late bool isMultiChoose;
  late List<String> answers;
  late int correctAnswer;

  Question({
    required this.question,
    required this.isMultiChoose,
    required this.answers,
    required this.correctAnswer,
  });
}