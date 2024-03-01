import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/discovery/discovery_category_list.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Most Ratified',
      'Top Seller',
      'may interest you',
      'Weekly content',
      'Recorded Content',
    ];
    var theme = Theme.of(context);
    return SafeArea(
      child: ConditionalBuilder(
        condition: true,
        builder: (context) => Column(
          children: [
        Padding(
        padding: const EdgeInsets.all(11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(categories[0], style: font.copyWith(color: theme.primaryColorDark,fontSize: 16.0,fontWeight: FontWeight.w500),),
              const Spacer(),
              TextButton(onPressed: () {navigateTo(context, CategoryList(pageName: categories[0]));},
                child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)])),
          ]
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
//List.generate(categories.length, (index) => null);