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
                return buildStudentChat(theme: theme, message: messages[index], context: context);
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
                          messages.add(Message(
                            senderUserName: 'sameh',
                            senderFirstName: student.firstName,
                            senderLastName: student.lastName,
                            messageContent: messageController.text,
                            messageDate: DateTime.now().minute.toString(),
                            senderProfileImage: student.imageProvider,
                          ));                        });
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
  })
  {
    if (message.senderUserName == 'sameh'){
      return userMessageItem(theme: theme, message: message, context: context);
    }
    else {
      return othersMessageItem(theme: theme, message: message);
    }
  }
}
Widget othersMessageItem({
  required ThemeData theme,
  required Message message,
})
{
  return Padding(
    padding: const EdgeInsets.only(right: 11,top: 6,bottom: 6,left: 50),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.6),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
        ),
      ),
      child:Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: theme.canvasColor.withOpacity(.4),
                radius: 25,
                backgroundImage: const AssetImage("Assets/profile/man_5.png"),
              ),
            ),
            Expanded(
              child: Text(message.messageContent,
                maxLines: 4,
                style: font.copyWith(fontSize: 23.0,fontWeight: FontWeight.w600,color: theme.primaryColorLight),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget userMessageItem({
  required BuildContext context,
  required ThemeData theme,
  required Message message,
})
{
  return Padding(
    padding: const EdgeInsets.only(right: 50,top: 6,bottom: 6,left: 11),
    child: Container(
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
          bottomLeft: Radius.circular(50.0),
        ),
      ),
      child:Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: theme.canvasColor.withOpacity(.4),
                radius: 25,
                backgroundImage: message.senderProfileImage,
              ),
            ),
            Expanded(
              child: Text(message.messageContent,
                maxLines: 4,
                textAlign:TextAlign.left,
                style: font.copyWith(fontSize: 23.0,fontWeight: FontWeight.w600,color: theme.primaryColorLight),

              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<Message> messages = [
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'sameh',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
];
