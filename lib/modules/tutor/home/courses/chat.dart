import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/components.dart';
import '../../../../shared/component/constant.dart';
import '../../../../shared/component/test.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double dy=0;
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {
          if(isTyping){
            setState(() {
              dy=10;
            });
          }else if(!isTyping){
            setState(() {
              dy=0;
            });
          }
        },
        builder: (context, state) {
          var teacher = InstructorCubit.get(context);
          return Scaffold(
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
              offset: Offset(0, dy),
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
                          onChanged:(value){
                            if(messageController.text.isNotEmpty){
                              setState(() {
                                isTyping =true;
                              });
                            }
                            else{
                              setState(() {
                                isTyping =false;
                              });
                            }
                          },
                          type: TextInputType.text,
                          validate: (s) {
                            return null;
                          },
                          label: "Type your message"),
                    ),
                    Expanded(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              var time = DateTime.now();
                              messages.add(Message(
                                  senderUserName: 'sameh',
                                  senderFirstName: teacher.firstName,
                                  senderLastName: teacher.lastName,
                                  messageContent: messageController.text,
                                  messageDate: '${time.hour}:${time.minute}',
                                  senderProfileImage: teacher.imageProvider,
                              ));
                            });
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
    if (message.senderUserName == 'sameh') {
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
  return Padding(
    padding: const EdgeInsets.only(right: 11, top: 6, bottom: 6, left: 50),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.6),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5,),
          SizedBox(
            width: screenWidth/5*3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${message.senderFirstName} ${message.senderFirstName} (${message.senderUserName})",
                  style: font.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColorLight),
                ),
                const SizedBox(height: 5,),
                Text(
                  message.messageContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: font.copyWith(
                      fontSize: 18.0,
                      color: theme.primaryColorLight),
                ),
                Text(
                  message.messageDate,
                  style: font.copyWith(
                      fontSize: 10.0,
                      color: theme.primaryColorLight),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundColor: theme.canvasColor.withOpacity(.4),
              radius: 25,
              backgroundImage: message.senderProfileImage ??
                  const AssetImage("Assets/profile/man_5.png"),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget userMessageItem({
  required BuildContext context,
  required ThemeData theme,
  required Message message,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 50, top: 6, bottom: 6, left: 11),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: CircleAvatar(
                  backgroundColor: theme.canvasColor.withOpacity(.4),
                  radius: 15,
                  backgroundImage: InstructorCubit
                      .get(context)
                      .imageProvider,
                ),
              ),
              const SizedBox(width: 5,),
              Text(
                "${message.senderFirstName} ${message.senderFirstName} (${message.senderUserName})",
                style: font.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColorLight),
              ),
              ]
          ),
          Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 70,),
                Text(
                  message.messageContent,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: font.copyWith(
                      fontSize: 18.0,
                      color: theme.primaryColorLight),
                ),
              ]
          ),
          Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  message.messageDate,
                  style: font.copyWith(
                      fontSize: 10.0,
                      color: theme.primaryColorLight),
                ),
              ]
          ),
        ],
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
      senderUserName: 's',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'can i ask a question',
      messageDate: '9:18'),
  Message(
      senderUserName: 'g',
      senderFirstName: 'sameh',
      senderLastName: 'sameh',
      messageContent: 'i just test chat,i just test chat,i just test chat,i just test chat,',
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
