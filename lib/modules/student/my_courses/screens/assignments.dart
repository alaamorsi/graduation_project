import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../../shared/component/components.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit,CourseStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme = Theme.of(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
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
                    onPressed: (){Navigator.pop(context);},
                    icon: Icon(Icons.arrow_back_ios,size: 20,color: Theme.of(context).primaryColor,),
                  ),
                ),
              ),
              title: const Text("Assignment"),
              bottom: TabBar(
                indicatorColor: theme.primaryColor,
                labelStyle: font.copyWith(color: theme.primaryColor, fontSize: 19.0),
                unselectedLabelStyle: font.copyWith(color: Colors.grey, fontSize: 16.0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Lesson Test'),
                  Tab(text: 'Assignment'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Lesson Test Tab
                SizedBox(
                  height: 100.0 *questions.length,
                  width: 200,
                  child: ConditionalBuilder(
                    condition: true,
                    builder: (BuildContext context) => ListView.builder(
                      itemBuilder: (context, index) => questionItem(context, index, questions[index]),
                      itemCount: questions.length,),
                    fallback: (BuildContext context) => Center(
                      child: Text(
                        "There are no quizzes",
                        style: font.copyWith(color: theme.primaryColor, fontSize: 19.0),
                      ),
                    ),
                  ),
                ),
                // Assignment Tab
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Assignment 1",
                            style: font.copyWith(
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "23 November 11.59pm",
                            style: font.copyWith(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "In legal terms, an assignment refers to the transfer of a right or liability from one party to another. It can involve property, financial agreements, or other legal matters",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: font.copyWith(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image(image: AssetImage('Assets/fading.jpg'), fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      const Spacer(),
                      usedButton(
                        paddingSize: 10,
                        radius: 5,
                        atEnd: false,
                        text: 'Add work',
                        color: Theme.of(context).cardColor,
                        context: context,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 15.0),
                      usedButton(
                        paddingSize: 10,
                        radius: 5,
                        atEnd: false,
                        text: 'submit',
                        color: Colors.black38,
                        context: context,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
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
            // setState(() {
            //   answered = !answered;
            // });
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