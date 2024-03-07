import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/test.dart';

class ReservedScreen extends StatelessWidget {
  const ReservedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme= Theme.of(context);
    return ConditionalBuilder(
      condition: courses.isNotEmpty,
      builder: (context) => SingleChildScrollView(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                indicatorColor: theme.primaryColor,
                labelStyle: font.copyWith(color: theme.primaryColor,fontSize: 19.0),
                unselectedLabelStyle: font.copyWith(color: Colors.grey,fontSize: 16.0),
                labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Online'),
                  Tab(text: 'Recorded'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.maxFinite,
                  height: screenHeight/7*courses.length+100,
                  child: TabBarView(
                    children: [
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: courses.length,
                          itemBuilder: (context ,index){
                            return paidCourse(
                                context: context,
                                course: courses[index],
                                color: theme.cardColor
                            );
                          }
                      ),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context ,index){
                            return paidCourse(
                                context: context,
                                course: courses[index],
                                color: theme.cardColor
                            );
                          }
                      ),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context ,index){
                            return paidCourse(
                                context: context,
                                course: courses[index],
                                color: theme.cardColor
                            );
                          }
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      fallback: (context) => const Center(child: Text('You are not in class yet')),
    );
  }
}
