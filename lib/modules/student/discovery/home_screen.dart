import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/course_demo/course_demo.dart';
import 'package:graduation_project/modules/student/discovery/discovery_category_list.dart';
import 'package:graduation_project/modules/student/paid_course/class_material.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/test.dart';
import '../../../shared/component/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final List<String> slides = [
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
                      Text(categories[1], style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0,fontWeight: FontWeight.w600),),
                      const Spacer(),
                      TextButton(onPressed: () {navigateTo(context, CategoryList(pageName: categories[0]));},
                        child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.bold)),)]),
                ),
                CarouselSlider(
                  items:slides.map((e) => slideItem(
                      context: context,
                      title: 'New Course!',
                      subTitle: e,
                      cardColor: theme.primaryColor,
                  )).toList(),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Courses', style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0,fontWeight: FontWeight.w600),),
                        const Spacer(),
                        TextButton(onPressed: () {navigateTo(context, CategoryList(pageName: categories[0]));},
                          child: Text('See all', style: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.bold)),)
                      ]
                  ),
                ),
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
                                itemBuilder: (context ,index)=> courseItem(
                                    context: context,
                                    imageUrl: courses[index].teacherImage,
                                    title: courses[index].subject,
                                    subTitle: courses[index].eduLevel,
                                    cardColor: theme.primaryColor,
                                    rate: 4.5,
                                    timer: courses[index].year,
                                    price: 450,
                                    lessonsNum: courses[index].videosNumber
                                )
                            )).toList()
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
}

Widget slideItem({
  required BuildContext context,
  required String title,
  required String subTitle,
  required Color cardColor,
  bool isReserved =false,
}) {
  return Padding(
    padding: const EdgeInsets.all(9.0),
    child: InkWell(
      onTap: isReserved?
          (){navigateTo(context, const ClassMaterial());}:
          (){navigateTo(context, const CourseDemo());},
      child: Container(
        width: screenWidth,
        height: screenHeight/4,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(23.0)),
          gradient: LinearGradient(colors: [cardColor,cardColor.withOpacity(0.5)]),
          // color: cardColor,
        ),
        child:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //teacher name
              Expanded(
                child: Text(title,
                  style: font.copyWith(
                      fontSize: 23.0, fontWeight: FontWeight.bold,color: Colors.white),
                  overflow: TextOverflow.ellipsis,),
              ),
              Expanded(
                child: Text(subTitle,
                  style: font.copyWith(
                      fontSize: 16.0,color: Colors.white),
                  overflow: TextOverflow.ellipsis,),
              ),
              Row(
                children: [
                  const SizedBox(width: 30.0),
                  Container(
                      padding: const EdgeInsets.all(9.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        color: Colors.orange,
                      ), child: Text("See Class",style: font.copyWith(fontSize: 16.0,color: Colors.white),)
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

//List.generate(categories.length, (index) => null);