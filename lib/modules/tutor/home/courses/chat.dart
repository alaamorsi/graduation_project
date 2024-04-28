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
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    var theme = Theme.of(context);
    return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var teacher = InstructorCubit.get(context);
          return Scaffold(
            appBar: secondAppbar(context: context, title: "Chat".tr),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return buildTeacherChat(
                    theme: theme, message: messages[index], context: context, cubit: teacher);
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
                          label: "Type your message"
                      ),
                    ),
                    Expanded(
                      child: IconButton(onPressed: () {
                        setState(() {
                          messages.add(Message(100, messageController.text, "now"));
                        });
                      }, icon: Icon(Icons.send_rounded, color: theme.primaryColor,)),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
  Widget buildTeacherChat({
    required BuildContext context,
    required ThemeData theme,
    required Message message,
    required Cubit cubit,
  })
  {
    if (message.senderId == 150){
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