import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_cubit.dart';
import 'package:graduation_project/layout/tutor/tutor_cubit/instructor_states.dart';
import 'package:graduation_project/models/chat_model.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../../shared/component/components.dart';
import '../../../../shared/component/constant.dart';

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
      hubConnection.on("getMessage", (List<Object?>? list){
        InstructorCubit.get(context).addMessageToChats(list![0].toString(),list[1].toString());
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
          var cubit = InstructorCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: secondAppbar(context: context, title: "Chat".tr),
            body: ListView.builder(
              itemBuilder: (context,index)=>
                  buildStudentChat(context: context, theme: theme, message: cubit.chat[index]),
              itemCount: cubit.chat.length,
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
                          validate: (String? val) {
                            return null;
                            }),
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
                            cubit.addMessageToChats(
                                CacheHelper.getData(key: 'userName'),
                                messageController.text
                            );
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

  Widget buildStudentChat({
    required BuildContext context,
    required ThemeData theme,
    required MessageModel message
  }) {
    if (message.userName == CacheHelper.getData(key: 'userName')) {
      return userMessageItem(theme: theme, message: message);
    } else {
      return othersMessageItem(theme: theme, message: message);
    }
  }
}

Widget othersMessageItem({
  required ThemeData theme,
  required MessageModel message,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(5),
        child: CircleAvatar(
          backgroundColor: theme.canvasColor.withOpacity(.4),
          radius: 20,
          backgroundImage: const AssetImage("Assets/profile/man_5.png"),
        ),
      ),
      Container(
        margin: EdgeInsets.only(right: isArabic ? 6 : 50, top: 3, bottom: 3, left: isArabic ? 50 : 6),
        padding: EdgeInsets.all(screenWidth * .03),
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.only(
            topLeft: isArabic ? const Radius.circular(20) : Radius.zero,
            topRight: isArabic ? Radius.zero : const Radius.circular(20),
            bottomRight: const Radius.circular(20),
            bottomLeft: const Radius.circular(20),
          ),
        ),
        child: Column(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.userName,
              style: font.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: theme.primaryColor),
            ),
            Text(
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              message.content,
              maxLines: 4,
              style: font.copyWith(
                  fontSize: screenWidth * 0.04,
                  color: theme.primaryColorLight),
            ),

          ],
        ),
      ),
    ],
  );
}

Widget userMessageItem({
  required ThemeData theme,
  required MessageModel message,
}) {
  return Container(
    margin: EdgeInsets.only(left: isArabic ? 11 : 50, top: 6, bottom: 6, right: isArabic ? 50 : 11),
    padding: EdgeInsets.all(screenWidth * .03),
    decoration: BoxDecoration(
      color: theme.canvasColor.withOpacity(.4),
      borderRadius: BorderRadius.only(
        topRight: isArabic ? const Radius.circular(20) : Radius.zero,
        topLeft: isArabic ? Radius.zero : const Radius.circular(20),
        bottomRight: const Radius.circular(20),
        bottomLeft: const Radius.circular(20),
      ),
    ),
    child: Column(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Text(
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
            message.content,
            maxLines: 4,
            style: font.copyWith(
                fontSize: screenWidth * 0.05,
                color: theme.primaryColorLight),
          ),
        ],
    )
  );
}
