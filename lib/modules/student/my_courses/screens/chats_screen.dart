import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../../shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import '../course_cubit/course_cubit.dart';
import '../course_cubit/course_states.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    var theme = Theme.of(context);
    return BlocConsumer<CourseCubit, CourseStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var student = StudentCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "Chat".tr),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return buildStudentChat(
                    theme: theme, message: messages[index], context: context, cubit: student);
              },
              itemCount: messages.length,
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 11, right: 11, bottom: 11),
              child: Container(
                padding: const EdgeInsets.all(9),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  color: theme.primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(18),),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      color: theme.primaryColorDark.withOpacity(.1),
                      offset: const Offset(0, -5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 3 / 4,
                      child: defaultFormField(
                          context: context,
                          controller: messageController,
                          type: TextInputType.text,
                          validate: (s) {
                            return null;
                          },
                          label: "Type your question"
                      ),
                    ),
                    Expanded(
                      child: IconButton(onPressed: () {
                        setState(() {
                          messages.add(Message(100, messageController.text, "now"));
                        });
                      }, icon: Icon(Icons.send_rounded, color: theme.primaryColor)),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      );
  }
  Widget buildStudentChat({
    required BuildContext context,
    required ThemeData theme,
    required Message message,
    required Cubit cubit,
  })
  {
    if (message.senderId == 100){
      return userMessageItem(theme: theme, message: message, context: context,cubit: cubit);
    }
    else {
      return othersMessageItem(theme: theme, message: message,cubit: cubit);
    }
  }
}

List<Message> messages=[
  Message(150, "can i ask a question", "9am"),
  Message(100, "test test test test test test test test test test test test test test test test test ", "9am"),
  Message(140, "can i ask a question", "9am"),
  Message(150, "can i ask a question", "9am"),
  Message(130, "can i ask a question", "9am"),
  Message(120, "can i ask a question", "9am"),
  Message(100, "from sameh", "9am"),
  Message(100, "from sameh", "9am"),
  Message(150, "can i ask a question", "9am"),
  Message(130, "can i ask a question", "9am"),
  Message(110, "can i ask a question", "9am"),
  Message(120, "can i ask a question", "9am"),
];

// class ChatsScreen extends StatelessWidget {
//   const ChatsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return BlocConsumer<CourseCubit,CourseStates>(
//         listener: (context,state) {},
//         builder:(context,state){
//           var course = CourseCubit.get(context);
//           return Scaffold(
//             appBar: secondAppbar(context: context, title: "Chat".tr),
//             body: ListView.builder(
//               itemBuilder: (BuildContext context, int index) {
//                 return buildMessageItem(theme: theme, message: messages[index], context: context, cubit: course);
//               },
//               itemCount: messages.length,
//             ),
//             bottomNavigationBar: Padding(
//               padding: const EdgeInsets.only(left: 11,right: 11,bottom: 11),
//               child: Container(
//                 padding: const EdgeInsets.all(9),
//                 width: double.infinity,
//                 height: 90,
//                 decoration: BoxDecoration(
//                   color: theme.primaryColorLight,
//                   borderRadius: const BorderRadius.all(Radius.circular(18),),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 15,
//                       color: theme.primaryColorDark.withOpacity(.1),
//                       offset: const Offset(0, -5),
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: screenWidth*3/4,
//                       child: defaultFormField(
//                           context: context,
//                           controller: messageController,
//                           type: TextInputType.text,
//                           validate: (s){
//                             return null;
//                           },
//                           label: "Type your question"
//                       ),
//                     ),
//                     IconButton(onPressed: (){
//                       setState(() {
//                         messages.add(Message(100, messageController.text, "now"));
//                       });
//                     }, icon: Icon(Icons.send_rounded,color: theme.primaryColor,size:45,))
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }
// Widget buildChatItem({
//   required BuildContext context,
//   required int index,
//   required MyCourse course,
//   required ThemeData theme,
//   required void Function() onTap,
// })
// {
//   return InkWell(
//     onTap: onTap,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 11,vertical: 6),
//       child: Container(
//         width: screenWidth,
//         height: screenHeight/6,
//         decoration: BoxDecoration(
//           color: theme.cardColor,
//           borderRadius: const BorderRadius.all(Radius.circular(23.0),),
//         ),
//         child:Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(course.lessons[index].lessonName,
//                 style: font.copyWith(fontSize: 23.0,fontWeight: FontWeight.w600,color: theme.primaryColorLight),
//               ),
//               const Spacer(),
//               Icon( Icons.arrow_forward_ios,color: theme.primaryColorLight,size: 30,),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
// }