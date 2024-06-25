import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/layout/student/student_cubit/student_states.dart';
import 'package:graduation_project/models/chat_model.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../shared/component/components.dart';
import '../../../shared/component/constant.dart';

class ChatsScreen extends StatefulWidget {
  final int courseId;
  const ChatsScreen({super.key, required this.courseId});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ScrollController _scrollController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _messageController = TextEditingController();
    hubConnection.start()?.then((value) {
      hubConnection.on("getMessage", (List<Object?>? list) {
        print(list![0]);
        print(list[1]);
        StudentCubit.get(context).addMessageToChats(list[0].toString(), list[1].toString());
        _scrollToBottom();
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {
        _scrollToBottom();
      },
      builder: (context, state) {
        var cubit = StudentCubit.get(context);
        _scrollToBottom();
        return Scaffold(
          appBar: secondAppbar(context: context, title: "Chat".tr),
          body: ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              return
              buildStudentChat(
              context: context,
              theme: theme,
              message: cubit.chat[index],
            );},
            itemCount: cubit.chat.length,
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(right:isArabic?screenWidth * .06:0,left:isArabic?0:screenWidth * .06),
            padding: EdgeInsets.all(screenWidth * .02),
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
                    controller: _messageController,
                    onChanged: (value) {},
                    type: TextInputType.text,
                    validate: (s) {
                      return null;
                    },
                    label: "Type your question".tr,
                  ),
                ),
                SizedBox(
                  width: screenWidth * .15,
                  child: IconButton(
                    onPressed: () {
                      final message = _messageController.text;
                      if (message.isNotEmpty) {
                        hubConnection.invoke(
                          "SendMessage",
                          args: <Object>[message, widget.courseId],
                        );
                        cubit.addMessageToChats(
                          CacheHelper.getData(key: 'userName'),
                          message,
                        );
                        _messageController.clear();
                        _scrollToBottom();
                      }
                    },
                    icon: Icon(
                      Icons.send_rounded,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStudentChat({
    required BuildContext context,
    required ThemeData theme,
    required MessageModel message,
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
  return Container(
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: theme.canvasColor.withOpacity(.4),
                radius: 20,
                child: Icon(Icons.person,color: theme.primaryColor,),
              ),
            ),
            Text(
              message.userName,
              style: font.copyWith(
                  fontSize: screenWidth * 0.06,
                  color: theme.primaryColor),
            ),
          ],
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
        color: theme.canvasColor,
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
