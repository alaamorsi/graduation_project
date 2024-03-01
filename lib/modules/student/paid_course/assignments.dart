import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import '../../../shared/component/components.dart';


List<bool> isOpen=List.filled(assignments.length, false);

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit, StudentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = StudentCubit.get(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              toolbarHeight: 70.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(11.0),
                  bottomRight: Radius.circular(11.0),
                ),
              ),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
              titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
              leading:Padding(
                padding: const EdgeInsets.only(
                    left: 11.0,top: 11.0,bottom: 11.0
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 6.0),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                  ),
                  child: IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: Icon(Icons.arrow_back_ios,size: 25,color: Theme.of(context).primaryColor,),
                  ),
                ),
              ),
              title: const Text('Course title'),
              actions:[Padding(padding: const EdgeInsets.only(right: 10.0),
                child:IconButton(onPressed: (){cubit.checkFavorite();},
                    icon: cubit.isFavorite? const Icon( Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_border)),),],
              bottom: TabBar(
                indicatorColor: Colors.white,
                labelStyle: font.copyWith(color: Colors.white,fontSize: 16.0),
                unselectedLabelStyle: font.copyWith(color: Colors.grey,fontSize: 14),
                tabs: const [
                  Tab(text: 'الواجبات'),
                  Tab(text: 'تم تسليمه'),
                ],
              ),
            ),
            body:   Container(
              padding: const EdgeInsets.all(25.0),
              width: double.infinity,
              child: TabBarView(
                children: [
                  //
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Assignment 1",style: font.copyWith(
                            color: Theme.of(context).cardColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                          ),
                          const Spacer(),
                          Text("23 نوفمبر 11.59م",style: font.copyWith(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Text("In legal terms, an assignment refers to the transfer of a right or liability from one party to another. It can involve property, financial agreements, or other legal matters",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: font.copyWith(
                          color: Colors.black,
                          fontSize: 16.0,),
                      ),
                      const SizedBox(height: 20.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 150,
                              width: 150,
                              child: Image(image: AssetImage('Assets/teacher.png'),fit: BoxFit.cover,)),
                        ],
                      ),
                      const Spacer(),
                      usedButton(
                        paddingSize: 10,
                        radius: 5,
                        atEnd: false,
                        text: 'اضافة عمل',
                        color: Theme.of(context).cardColor,
                        context: context,
                        onPressed:(){},
                      ),
                      const SizedBox(height: 15.0),
                      usedButton(
                        paddingSize: 10,
                        radius: 5,
                        atEnd: false,
                        text: 'تسليم',
                        color: Colors.black38,
                        context: context,
                        onPressed:(){},
                      ),
                    ],
                  ),
                  //تم تسليمه
                  ListView.builder(
                    itemBuilder: (context,index)=>buildAssignmentsList(context, index, assignments,isOpen),
                    itemCount: assignments.length,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildAssignmentsList(
      BuildContext context,
      int index,
      List<Assignment> assignments,
      List<bool> isOpen,
  )
  {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              isOpen[index]=!isOpen[index];
            });
          },
          child: Container(
            width: screenWidth,
            height: screenHeight/13,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(isOpen[index]?  Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,size: 45.0,),
                const Spacer(),
                Text(assignments[index].name,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                const SizedBox(width: 10.0,),
              ],
            ),
          ),
        ),
        ConditionalBuilder(
          condition: isOpen[index],
          builder:(context)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(assignments[index].details,style: font.copyWith(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 13.0),),
            ],
          ),
          fallback: (context)=>Container(),
        ),
      ],
    );
  }
}

class Assignment{
  late String name;
  // late DateTime time;
  late String details;
  late String other;

  Assignment({
    required this.name,
    // required this.time,
    required this.details,
    required this.other,
  });
}

List<Assignment> assignments=[
  Assignment(name: 'A1', details: 'ppppppppppppppppppppppppppp', other: 'other'),
  Assignment(name: 'A2', details: 'ccccccccccccccccccccccccccc', other: 'other'),
  Assignment(name: 'A3', details: 'ggggggggggggggggggggggggggg', other: 'other'),
];