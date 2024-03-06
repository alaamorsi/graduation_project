import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: secondAppbar(context: context, title: 'WishList'),
    );
  }
}
