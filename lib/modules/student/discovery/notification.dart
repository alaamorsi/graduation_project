import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: secondAppbar(context: context, title: 'Notifications'),
    );
  }
}
