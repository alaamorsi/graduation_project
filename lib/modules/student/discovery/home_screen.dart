import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/discovery/discovery_category_list.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'All',
      'Most Ratified',
      'Top Seller',
      'may interest you',
      'Weekly content',
      'Recorded Content',
    ];

    var cubit = StudentCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
        return ConditionalBuilder(
            condition: true,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Special", style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0,fontWeight: FontWeight.w300),),
                          const Spacer(),
                          TextButton(onPressed: () {navigateTo(context, const CategoryList());},
                            child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300)),)]),
                    ),
                    CarouselSlider(
                      items:[
                        slideItem(context: context, title: "Science is Amazing", id: 1, image: "Assets/subjects_icon/science.png"),
                        slideItem(context: context, title: "Learn English Easy", id: 2, image: "Assets/subjects_icon/alphabet.png"),
                        slideItem(context: context, title: "Know more about History", id: 1, image: "Assets/subjects_icon/history.png"),
                        slideItem(context: context, title: "Atoms is too Tiny", id: 2, image: "Assets/subjects_icon/atom.png"),
                        slideItem(context: context, title: "Is that A Ball !!!", id: 1, image: "Assets/subjects_icon/ball.png"),
                        slideItem(context: context, title: "It's look like a Cube", id: 2, image: "Assets/subjects_icon/block.png"),
                        slideItem(context: context, title: "Dna what it Mean !", id: 1, image: "Assets/subjects_icon/dna.png"),
                        slideItem(context: context, title: "Geology is Funny now", id: 2, image: "Assets/subjects_icon/globe.png"),
                        slideItem(context: context, title: "Find Great Idea !", id: 1, image: "Assets/subjects_icon/idea.png"),
                        slideItem(context: context, title: "Math is not that hard", id: 2, image: "Assets/subjects_icon/maths.png"),
                        slideItem(context: context, title: "What is Solar System", id: 1, image: "Assets/subjects_icon/solar-system.png"),
                        slideItem(context: context, title: "Did you know it !!!", id: 2, image: "Assets/subjects_icon/square-root.png"),
                      ],
                      options: CarouselOptions(
                        height: screenHeight/4,
                        initialPage: 0,
                        viewportFraction: 1,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                    ),
                    newDivider(),
                    DefaultTabController(
                      length: categories.length,
                      child: Column(
                        children: [
                          TabBar(
                              indicatorColor: Colors.transparent,
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              labelStyle: font.copyWith(color: theme.primaryColor,fontSize: 19.0),
                              unselectedLabelStyle: font.copyWith(color: Colors.grey,fontSize: 16.0),
                              labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                              dividerColor: Colors.transparent,
                              tabs: categories.map((e) => Tab(text: e)).toList()
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: ((screenHeight/7)*(categories.length)+100),
                            child: TabBarView(
                                children: categories.map((e) => ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: categories.length,
                                    itemBuilder: (context ,index){
                                      int rate = 0;
                                      for (var element in courses[index].review) {
                                        rate = rate + element.rate;
                                      }
                                      rate = rate~/(courses[index].review.length);
                                      return courseItem(
                                          context: context,
                                          course: courses[index],
                                          rate: rate,
                                          color: theme.cardColor,
                                          addToWishList:(){cubit.addToWishList(courses[index]);}
                                      );
                                    })
                                ).toList()
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
      }
    );
  }
}
