import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../shared/component/constant.dart';

class CourseDemo extends StatelessWidget {
  const CourseDemo({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    cubit.fullPaidList(4);
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
            appBar:AppBar(
              toolbarHeight: 70.0,
              bottomOpacity: 0.7,
              elevation: 2.0,
              shadowColor: Colors.grey,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70.0),
                  bottomRight: Radius.circular(70.0),
                ),
              ),
              leading: IconButton(
                  onPressed: (){Navigator.pop(context);},
                  icon: const Icon(Icons.arrow_back_ios_rounded)
              ),
              title: const Text('تفاصيل الدورة'),
              centerTitle: true,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              actions: [
                IconButton(onPressed: (){
                  cubit.checkFavorite();
                }, icon: cubit.isFavorite? const Icon( Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_border)),
                const SizedBox(width: 10.0,)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Flexible(
                    child: ConditionalBuilder(
                        condition: true,
                        builder: (context)=>ListView.separated(
                            itemBuilder: (context , index)=>buildDemoItem(context,index,cubit.isPaid[index]),
                            separatorBuilder: (context , index)=>const SizedBox(width: double.infinity,height: 5.0,),
                            itemCount: 4,
                        ),
                        fallback: (context)=>const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  const SizedBox(height: 3.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: usedButton(
                      atEnd: false,
                      text: 'حجز الآن',
                      color: Theme.of(context).cardColor,
                      context: context,
                      onPressed:(){cubit.checkPayment(4);},
                    ),
                  ),
                ],
              ),
            ),
        );
      },
    );
  }

  Widget buildDemoItem(BuildContext context,int index,bool paid)
  {
    var cubit = StudentCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              cubit.checkViewDemoList(index);
            },
            child: Container(
              width: screenWidth,
              height: screenHeight/13,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(cubit.demoList[index]?  Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,size: 45.0,),
                  const Spacer(),
                  Text('مقدمة عن المحتوى',style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
                  const SizedBox(width: 10.0,),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).cardColor,
                    child: Text('${index+1}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
          ConditionalBuilder(
            condition: cubit.demoList[index],
            builder:(context)=> ListView.separated(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index)=>Padding(
                  padding: const EdgeInsets.symmetric(horizontal:11.0),
                  child: TextButton(
                    onPressed: paid?(){} : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(paid? Icons.ondemand_video : Icons.lock_rounded,color: Theme.of(context).cardColor,),
                        const Spacer(),
                        Text('${index+1}',style: Theme.of(context).textTheme.titleSmall,)
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index)=>const SizedBox(height: 3.0,),
                itemCount: 5),
            fallback: (context)=>Container(),
          ),
        ],
      ),
    );
  }
}
