import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../shared/component/components.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({super.key});

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}
class _ExamsScreenState extends State<ExamsScreen> {
  List<List<bool>> selected = [
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
    [false,false,false,false],
  ];
  List<String> studentAnswers=[];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar:secondAppbar(context: context, title: "Exams".tr),
      body:Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal:screenWidth * .02),
            child: ConditionalBuilder(
              condition: true,
              builder: (BuildContext context) => SizedBox(
                height: screenHeight-152,
                child: ListView.builder(
                  itemBuilder: (context, index) => questionItem(context, index, questions[index]),
                  itemCount: questions.length,),
              ),
              fallback: (BuildContext context) => Center(
                child: Text(
                  "There are no quizzes",
                  style: font.copyWith(color: theme.primaryColor, fontSize: 19.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: usedButton(
              atEnd: false,
              text: 'Submit'.tr,
              color: theme.canvasColor,
              radius: 30,
              paddingSize: 10,
              context: context,
              onPressed:(){
                print(studentAnswers);
              },
            ),
          ),
        ],
      ),

    );
  }

  Widget questionItem(
      BuildContext context,
      int qNumber,
      Question question,)
  {
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
                  child: Text('Q ${qNumber+1}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
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
                  chooseItem(context,qNumber ,question.answers[0], 0),
                  chooseItem(context,qNumber ,question.answers[1], 1),
                  chooseItem(context,qNumber ,question.answers[2], 2),
                  chooseItem(context,qNumber ,question.answers[3], 3),
                ],
              ),
              fallback: (context)=>Wrap(
                children: [
                  chooseItem(context,qNumber ,question.answers[0], 0),
                  chooseItem(context,qNumber ,question.answers[1], 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if(isSelected){
        studentAnswers.add(itemValue);
      }
      else{
        studentAnswers.remove(itemValue);
      }
    });
  }

  Widget chooseItem(BuildContext context,int qNumber,String answer,int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FilterChip(
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),),
          label: Text(answer),
          labelStyle: font.copyWith(fontSize: 12.0, color: Colors.white,),
          selected: selected[qNumber][index],
          backgroundColor: Colors.grey,
          selectedColor: Theme.of(context).canvasColor,
          onSelected: (bool select){
            setState(() {
              if(questions[qNumber].isMultiChoose){
                for(int i=0;i<4;i++) {
                  if(i==index){
                    selected[qNumber][index] = !selected[qNumber][index];
                    continue;
                  }
                  selected[qNumber][i] = false;
                  itemChange('$qNumber : ${questions[qNumber].answers[i]}', false);
                }
              }else{
                for(int i=0;i<2;i++) {
                  if(i==index){
                    selected[qNumber][index] = !selected[qNumber][index];
                    continue;
                  }
                  selected[qNumber][i] = false;
                  itemChange('$qNumber : ${questions[qNumber].answers[i]}', false);
                }
              }
              itemChange('$qNumber : $answer', select);
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
