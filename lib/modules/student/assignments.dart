import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/component/components.dart';

class assignmentScreen extends StatefulWidget {
  const assignmentScreen({super.key});

  @override
  State<assignmentScreen> createState() => _assignmentScreenState();
}

class _assignmentScreenState extends State<assignmentScreen> {
  @override
  GlobalKey<ScaffoldState> scafoldkay = GlobalKey();
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            key: scafoldkay,
            appBar: AppBar(
                toolbarHeight: 70.0,
                bottomOpacity: 0.7,
                elevation: 2.0,
                shadowColor: HexColor("#666666"),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70.0),
                    bottomRight: Radius.circular(70.0),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30.0,
                      )),
                ),
                title: Text(
                  "Assignment",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w300),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 11.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        "Assets/teacher.png",
                      ),
                    ),
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: Colors.blueGrey,
                  labelColor: Colors.white,
                  tabs: [
                    Tab(text: 'الواجبات'),
                  Tab(text: 'تم تسليمه'),

                ],),
            ),
            body:   Container(
              padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: TabBarView(
                key: scafoldkay,
                children: [
                TabBarView(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Text("Assignment 1",style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          ),
                          SizedBox(width: 100,),
                          Text("23 نوفمبر 11.59م",style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,

                          )),


                        ],),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              height: 200,
                              child: Image(image: AssetImage('Assets/teacher.png'))),
                        ],
                      ),
                      SizedBox(height: 80,),
                      Column(
                        children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: usedButton(
                            paddingSize: 20,
                            radius: 5,
                            atEnd: false,
                            text: '  +اضافه عمل',
                            color: Theme.of(context).cardColor,

                            context: context,
                            onPressed:(){},
                          ),
                        ),
                          SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: usedButton(
                            paddingSize: 20,
                            radius: 5,
                            atEnd: false,
                            text: 'تسليم',
                            color: Theme.of(context).cardColor,
                            context: context,
                            onPressed:(){},
                          ),
                        ),
                      ],)

                    ],
                  ),
                  ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 200,
                              height: 300,
                              margin: const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage("Assets/teacher.png"),
                                    fit: BoxFit.fitHeight),
                              ),
                            ));
                      }),
                ],),
           ], ),

          ),
          ), );
      },
    );
  }
}
