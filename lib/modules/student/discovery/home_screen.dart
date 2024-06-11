import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/student/discovery/search_screen.dart';
import 'package:graduation_project/modules/student/discovery/special_subject_page.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
import '../../../models/courses_model.dart';
import '../../../shared/component/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'wish_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'All',
      'Most Ratified',
      // 'Top Seller',
      // 'may interest you',
      // 'Weekly content',
      // 'Recorded Content',
    ];
    var cubit = StudentCubit.get(context);
    var theme = Theme.of(context);
    String firstName = CacheHelper.getData(key: 'firstName').toString();
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                centerTitle: false,
                title: 'Hello'.tr + firstName.replaceRange(0, 1, firstName[0].toUpperCase()),
                actions: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(9.0)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        navigateTo(context, const SearchScreen());
                      },
                      icon: Icon(
                        Icons.search,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: IconButton(
                        onPressed: () {
                          navigateTo(context, const WishListScreen());
                        },
                        icon: Icon(Icons.favorite,
                            size: 25, color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ]),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth *0.01),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth *0.05),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Subjects".tr,
                              style: font.copyWith(
                                  color: theme.primaryColorDark,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300),
                            ),
                            const Spacer(),
                          ]),
                    ),
                    CarouselSlider(
                      items: subjects
                          .map(
                            (element) => slideItem(
                                context: context,
                                title: element.tr,
                                image: "Assets/subjects_icon/$element.png",
                                onTap: () {
                                  Get.to(()=>SpecialSubjectPage(subjectName: element));
                                }),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: screenHeight / 4,
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
                              labelStyle: font.copyWith(
                                  color: theme.primaryColor, fontSize: 19.0),
                              unselectedLabelStyle: font.copyWith(
                                  color: Colors.grey, fontSize: 16.0),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              dividerColor: Colors.transparent,
                              tabs: categories
                                  .map((e) => Tab(text: e.tr))
                                  .toList()),
                          SizedBox(
                            width: double.maxFinite,
                            height: ((screenHeight / 7) * (categories.length) + 100),
                            child: TabBarView(
                                children: [
                                FutureBuilder(
                                    future: allCourse,
                                    builder: (BuildContext context, AsyncSnapshot<List<CourseModel>> snapshot){
                                      if(snapshot.hasError){
                                        return const Text("something wrong");
                                      }else if(snapshot.hasData){
                                        final data = snapshot.data;
                                        return ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemCount: data!.length,
                                            itemBuilder: (context, index) {
                                              return courseItem(
                                                  context: context,
                                                  course: data[index],
                                                  color: theme.cardColor,
                                                  addToWishList: () {
                                                    cubit.addToWishList(
                                                        courses[index]);
                                                  });
                                            });
                                      }
                                      else{
                                        return Center(child: CircularProgressIndicator(color: Colors.red.shade800,));
                                      }
                                    }
                                  ),
                                  FutureBuilder<List<CourseModel>>(
                                      future: allCourse,
                                      builder: (BuildContext context, AsyncSnapshot<List<CourseModel>> snapshot){
                                        if(snapshot.hasError){
                                          return const Text("something wrong");
                                        }else if(snapshot.hasData){
                                          final data = snapshot.data;
                                          return ListView.builder(
                                              physics:
                                              const NeverScrollableScrollPhysics(),
                                              itemCount: categories.length,
                                              itemBuilder: (context, index) {
                                                return courseItem(
                                                    context: context,
                                                    course: data![index],
                                                    color: theme.cardColor,
                                                    addToWishList: () {
                                                      cubit.addToWishList(
                                                          courses[index]);
                                                    });
                                              });
                                        }
                                        else{
                                          return Center(child: CircularProgressIndicator(color: Colors.red.shade800,));
                                        }
                                      }
                                  ),
                                ],
                          ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }
}
