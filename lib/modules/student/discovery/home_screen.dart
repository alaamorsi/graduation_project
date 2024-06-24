import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/models/courses_model.dart';
import 'package:graduation_project/modules/student/discovery/search_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';
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
      'Top Seller',
      'Recorded Content',
    ];
    var cubit = StudentCubit.get(context);
    var theme = Theme.of(context);
    cubit.getCourses(1);
    cubit.getTopSalesCourses();
    cubit.getTopRatedCourses();
    String firstName = CacheHelper.getData(key: 'firstName').toString();
    return BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {
          if(state is GetCoursesErrorState){
            cubit.getCourses(1);
          } else if(state is GetTopRatedCoursesErrorState){
            cubit.getTopRatedCourses();
          } else if(state is GetTopSalesCoursesErrorState){
            cubit.getTopSalesCourses();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                centerTitle: false,
                title:
                    '${'Hello'.tr} ${firstName.replaceRange(0, 1, firstName[0].toUpperCase())}',
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
                          cubit.getFavouriteList();
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
                  padding: EdgeInsets.all(screenWidth * 0.01),
                  child: Column(children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                              onTap:(int num){
                                cubit.changeListNum(num);
                              },
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
                            height: (cubit.allCourses.length.toInt() == 0)
                                ? screenHeight / 3
                                : cubit.allCourses.length.toInt() * screenHeight / 7,
                            child: TabBarView(
                              children: [
                                coursesCardList(
                                    state, cubit, theme, cubit.allCourses),
                                coursesCardList(
                                    state, cubit, theme, cubit.topRatedCourses),
                                coursesCardList(
                                    state, cubit, theme, cubit.topSalesCourses),
                                coursesCardList(
                                    state, cubit, theme, cubit.allCourses),
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

  Widget coursesCardList(StudentStates state, StudentCubit cubit, ThemeData theme, List<CourseModel> courseTypes)
  {
    return ConditionalBuilder(
      condition: cubit.allCourses.isNotEmpty,
      builder: (context) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courseTypes.length,
            itemBuilder: (context, index) {
              if (cubit.allCourses.isEmpty) {
                return Center(
                  child: Text(
                    'There are no courses yet',
                    style: font.copyWith(
                        color: theme.primaryColor,
                        fontSize: screenWidth * 0.06),
                  ),
                );
              }
              return courseItem(
                  context: context,
                  course: courseTypes[index],
                  color: theme.cardColor,
                  addToWishList: () {
                    cubit.addToFavourite(courseTypes[index]);
                  });
            });
      },
      fallback: (BuildContext context) {
        if (state is GetCoursesLoadingState) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            ),
          );
        } else if (state is GetCoursesErrorState) {
          return Text("Ops , SomeThing went wrong",
            style: font.copyWith(
              color: theme.primaryColor,
              fontSize: screenWidth * 0.06),
          );
        }
        else{
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                color: theme.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
