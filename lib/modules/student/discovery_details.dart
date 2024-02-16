import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';

class DiscoveryDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var cubit = StudentCubit.get(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
            appBar: AppBar(
              title: Text('تفاصيل الدورة'),
              centerTitle: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              actions: [
                IconButton(onPressed: (){
                  cubit.checkFavorite();
                }, icon: cubit.isFavorite? Icon( Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border)),
                SizedBox(width: 10.0,)
              ],
            ),
            body: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    cubit.checkViewDemoList(1);
                  },
                  child: Container(
                    width: screenWidth,
                    height: screenHeight/13,
                    color: cubit.demoList[1]? Colors.black26 : Colors.black12,
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(cubit.demoList[1]?  Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                          Spacer(),
                          Text('مقدمة عن المحتوى',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10.0,),
                          CircleAvatar(
                            child: Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.demoList[1],
                  builder:(context)=> ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index)=>Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.play_circle),
                                  Spacer(),
                                  SizedBox(height: 10.0,),
                                  Text('تعريف بالمدرس',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index)=>SizedBox(height: 5.0,),
                      itemCount: 10),
                  fallback: (context)=>Container(),
                ),
                Container(width: double.infinity,height: 5.0,),
                Flexible(
                  child: ConditionalBuilder(
                      condition: true,
                      builder: (context)=>ListView.separated(
                          itemBuilder: (context , index)=>buildDemoListItem(context,index),
                          separatorBuilder: (context , index)=>Container(width: double.infinity,height: 5.0,),
                          itemCount: 4,
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: ElevatedButton(
                      onPressed: (){
                        cubit.checkPayment();
                      },
                      child: Center(child: Text('حجز الآن',style: TextStyle(fontSize: 20.0,color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
        );
      },
    );
  }
  Widget buildDemoListItem(context,index)
  {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var cubit = StudentCubit.get(context);
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            cubit.checkViewDemoList(index);
          },
          child: Container(
            width: screenWidth,
            height: screenHeight/13,
            color: cubit.demoList[index]? Colors.black26 : Colors.black12,
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(cubit.demoList[index]?  Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                  Spacer(),
                  Text('مقدمة عن المحتوى',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  SizedBox(width: 10.0,),
                  CircleAvatar(
                    child: Text('${index+2}',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),
        ),
        ConditionalBuilder(
          condition: cubit.demoList[index],
          builder:(context)=> ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index)=>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: cubit.isPaid?(){} : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(cubit.isPaid? Icons.play_circle : Icons.lock),
                          Spacer(),
                          SizedBox(height: 10.0,),
                          Text('تعريف بالمدرس',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index)=>SizedBox(height: 5.0,),
              itemCount: 10),
          fallback: (context)=>Container(),
        ),
      ],
    );
  }
}
