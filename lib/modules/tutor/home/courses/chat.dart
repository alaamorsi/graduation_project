import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../../shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import '../../../../shared/component/test.dart';

class ChatScreen extends StatefulWidget {
  final int courseId;
  const ChatScreen({super.key, required this.courseId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isTyping = false;
  @override
  void initState() {
    hubConnection.start()?.then((value){
      //handle the on to show the messages
      hubConnection.on("getMessage", (List<Object?>? list){
        print("Signal R #######################################");
        print(list![0].toString());
        print(list[1].toString());
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var teacher = InstructorCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: secondAppbar(context: context, title: "Chat".tr),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return buildTeacherChat(
                    theme: theme, message: messages[index], context: context);
              },
              itemCount: messages.length,
            ),
            bottomNavigationBar: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              offset: const Offset(0, 0),
              child: Container(
                margin: EdgeInsets.only(left: screenWidth * .02,
                    right: screenWidth * .02,
                    bottom: screenWidth * .02),
                padding: EdgeInsets.all(screenWidth * .03),
                width: double.infinity,
                height: 90,
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
                      width: screenWidth * 0.75,
                      child: defaultFormField(
                          context: context,
                          controller: messageController,
                          label: "Type your message",
                          type: TextInputType.text,
                          validate: (String? val) {  }),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () {
                            hubConnection.invoke(
                                "SendMessage",
                                args: <Object>[
                                  messageController.text,
                                  widget.courseId
                                ]
                            );
                            print(messageController.text,);
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: theme.primaryColor,
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildTeacherChat({
    required BuildContext context,
    required ThemeData theme,
    required Message message,
  }) {
    if (message.senderFirstName == CacheHelper.getData(key: 'firstName')) {
      return userMessageItem(
        theme: theme,
        message: message,
        context: context,
      );
    } else {
      return othersMessageItem(theme: theme, message: message);
    }
  }
}

Widget othersMessageItem({
  required ThemeData theme,
  required Message message,
}) {
  return Container(
    margin: EdgeInsets.only(right: isArabic ? 11 : 50, top: 6, bottom: 6, left: isArabic ? 50 : 11),
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
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundColor: theme.canvasColor.withOpacity(.4),
            radius: 25,
            backgroundImage: const AssetImage("Assets/profile/man_5.png"),
          ),
        ),
        Column(
          children: [
            Text(
              message.senderFirstName + message.senderLastName,
              style: font.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: theme.primaryColor),
            ),
            Text(
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              message.messageContent,
              maxLines: 4,
              style: font.copyWith(
                  fontSize: screenWidth * 0.05,
                  color: theme.primaryColorLight),
            ),
          ],
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
    margin: EdgeInsets.only(left: isArabic ? 11 : 50, top: 6, bottom: 6, right: isArabic ? 50 : 11),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              message.senderFirstName + message.senderLastName,
              style: font.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: theme.primaryColorLight),
            ),
            Text(
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              message.messageContent,
              maxLines: 4,
              style: font.copyWith(
                  fontSize: screenWidth * 0.05,
                  color: theme.primaryColorLight),
            ),
          ],
        ),
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

List<Message> messages = [
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'i just test',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'Mohamed',
      senderLastName: 'Ahmed',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
];
