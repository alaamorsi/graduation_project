import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/discovery/discovery_category_list.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../shared/component/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'notification.dart';
import 'wish_list.dart';

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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            toolbarHeight: 70.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
            ),
            title: Text('Hello,${CacheHelper.getData(key: 'firstName')}!',
              style: font.copyWith(fontSize: 24.0,fontWeight: FontWeight.w600,color: Theme.of(context).primaryColorDark),
            ),
            actions:[
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                ),
                child: IconButton(
                  onPressed: (){navigateTo(context, const NotificationsScreen());},
                  icon: Icon(Icons.notifications,size: 25,color: Theme.of(context).primaryColor,),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal:10.0),
                child:Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: IconButton(
                    onPressed: (){navigateTo(context, const WishListScreen());},
                    icon: Icon(Icons.favorite,size: 25,color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
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
                        slideItem(context: context, title: "Learn English Easy", id: 1, image: "Assets/subjects_icon/alphabet.png"),
                        slideItem(context: context, title: "Know more about History", id: 2, image: "Assets/subjects_icon/history.png"),
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
                                      for (var element in courses[index].preview) {
                                        rate = rate + element.rate;
                                      }
                                      rate = rate~/(courses[index].preview.length);
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
          ),
        );
      }
    );
  }
}
