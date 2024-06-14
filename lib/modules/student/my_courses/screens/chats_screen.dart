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
  double dy = 0;
  bool isTyping = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    var theme = Theme.of(context);
    return BlocProvider(
      create: (BuildContext context) => CourseCubit(),
      child:
          BlocConsumer<CourseCubit, CourseStates>(listener: (context, state) {
        if (isTyping) {
          setState(() {
            dy = 10;
          });
        } else if (!isTyping) {
          setState(() {
            dy = 0;
          });
        }
      }, builder: (context, state) {
        var student = StudentCubit.get(context);
        return Scaffold(
          appBar: secondAppbar(context: context, title: "Chat".tr),
          body: buildStudentChat(context: context, theme: theme),
          bottomNavigationBar: AnimatedSlide(
            duration: const Duration(milliseconds: 500),
            offset: Offset(0, dy),
            child: Container(
              margin: EdgeInsets.only(
                  left: screenWidth * .02,
                  right: screenWidth * .02,
                  bottom: screenWidth * .02),
              padding: EdgeInsets.all(screenWidth * .03),
              width: double.infinity,
              height: screenHeight * .1,
              decoration: BoxDecoration(
                color: theme.primaryColorLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(screenWidth * .7),
                ),
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
                    width: screenWidth * .75,
                    child: defaultFormField(
                        context: context,
                        controller: messageController,
                        onChanged: (value) {
                          if (messageController.text.isNotEmpty) {
                            setState(() {
                              isTyping = true;
                            });
                          } else {
                            setState(() {
                              isTyping = false;
                            });
                          }
                        },
                        type: TextInputType.text,
                        validate: (s) {
                          return null;
                        },
                        label: "Type your question"),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            messages.add(Message(
                              senderUserName: 'sameh',
                              senderFirstName: student.firstName,
                              senderLastName: student.lastName,
                              messageContent: messageController.text,
                              messageDate: DateTime.now().minute.toString(),
                              senderProfileImage: student.imageProvider,
                            ));
                          });
                        },
                        icon: Icon(Icons.send_rounded,
                            color: theme.primaryColor)),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildStudentChat({
    required BuildContext context,
    required ThemeData theme,
  }) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (messages[index].senderUserName == 'sameh') {
          return userMessageItem(
              theme: theme, message: messages[index], context: context);
        } else {
          return othersMessageItem(theme: theme, message: messages[index]);
        }
      },
      itemCount: messages.length,
    );
  }
}

Widget othersMessageItem({
  required ThemeData theme,
  required Message message,
}) {
  return Container(
    margin: EdgeInsets.only(
        right: isArabic ? 11 : 50, top: 6, bottom: 6, left: isArabic ? 50 : 11),
    padding: EdgeInsets.all(screenWidth * .03),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(.6),
      borderRadius: BorderRadius.only(
        topLeft: isArabic ? const Radius.circular(30) : Radius.zero,
        topRight: isArabic ? Radius.zero : const Radius.circular(30),
        bottomRight: const Radius.circular(30),
        bottomLeft: const Radius.circular(30),
      ),
    ),
    child: Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isArabic)
          Padding(
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor: theme.canvasColor.withOpacity(.4),
              radius: 25,
              backgroundImage: const AssetImage("Assets/profile/man_5.png"),
            ),
          ),
        GridView.count(
          crossAxisCount: 1,
          children: [
            Text(
              message.senderUserName,
              style: font.copyWith(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor),
            ),
            Text(
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              message.messageContent,
              maxLines: 4,
              style: font.copyWith(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w400,
                  color: theme.primaryColorLight),
            ),
          ],
        ),
        if (!isArabic)
          Padding(
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor: theme.canvasColor.withOpacity(.4),
              radius: 25,
              backgroundImage: const AssetImage("Assets/profile/man_5.png"),
            ),
          ),
      ],
    ),
  );
}

Widget userMessageItem({
  required BuildContext context,
  required ThemeData theme,
  required Message message,
}) {
  return Container(
    margin: EdgeInsets.only(
        left: isArabic ? 11 : 50, top: 6, bottom: 6, right: isArabic ? 50 : 11),
    padding: EdgeInsets.all(screenWidth * .03),
    decoration: BoxDecoration(
      color: theme.primaryColor,
      borderRadius: BorderRadius.only(
        topRight: isArabic ? const Radius.circular(30.0) : Radius.zero,
        topLeft: isArabic ? Radius.zero : const Radius.circular(30),
        bottomRight: const Radius.circular(30),
        bottomLeft: const Radius.circular(30),
      ),
    ),
    child: Row(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            message.messageContent,
            maxLines: 4,
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            style: font.copyWith(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w600,
                color: theme.primaryColorLight),
          ),
        ),
      ],
    ),
  );
}

List<Message> messages = [
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'Mohamed',
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
];
