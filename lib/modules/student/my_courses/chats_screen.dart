import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/components.dart';
import '../../../shared/component/constant.dart';

class ChatsScreen extends StatefulWidget {
  final int courseId;
  const ChatsScreen({super.key, required this.courseId});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    hubConnection.start()?.then((value){
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
    return  BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
      var student = StudentCubit.get(context);
      return Scaffold(
        appBar: secondAppbar(context: context, title: "Chat".tr),
        body: buildStudentChat(context: context, theme: theme),
        bottomNavigationBar: AnimatedSlide(
          duration: const Duration(milliseconds: 500),
          offset: Offset(0, 0),
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
                      onChanged: (value) {},
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
                          hubConnection.invoke(
                              "SendMessage",
                              args: <Object>[
                                messageController.text,
                                widget.courseId
                              ]
                          );
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
    });
  }

  Widget buildStudentChat({
    required BuildContext context,
    required ThemeData theme,
  }) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (messages[index].senderFirstName == 'sameh') {
          return userrMessageItem(
              theme: theme, message: messages[index], context: context);
        } else {
          return otherMessageItem(theme: theme, message: messages[index]);
        }
      },
      itemCount: messages.length,
    );
  }
}

Widget otherMessageItem({
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
              message.senderFirstName + message.senderLastName,
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

Widget userrMessageItem({
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
