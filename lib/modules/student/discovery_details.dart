import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/components.dart';

class DiscoveryDetails extends StatelessWidget {
  const DiscoveryDetails({super.key});


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var cubit = AppCubit.get(context);
    var theme = Theme.of(context);
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state ){},
      builder: (context , state ){
        return Scaffold(
            appBar: defaultAppBar(
                context: context,
                leadingIcon: Icons.arrow_back_ios_outlined,
                leadingFunction: (){Navigator.pop(context);},
                title:  const Text('تفاصيل الدورة'),
                atEndIcon: Icons.favorite_border
            ),
            body: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight/13,
                  color: Colors.white.withOpacity(0.0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: (){
                        cubit.checkViewDemoList();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(cubit.isOpened?  Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,size: 35.0,),
                            const Spacer(),
                            Text('مقدمة عن المحتوى',style: theme.textTheme.titleMedium,),
                            const SizedBox(width: 10.0,),
                            CircleAvatar(
                              backgroundColor: Theme.of(context).canvasColor,
                              radius: 15.0,
                              child: const Text('1',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ConditionalBuilder(
                  condition: cubit.isOpened,
                  builder:(context)=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 39.0,vertical: 11.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.play_circle,color: theme.canvasColor,),
                            const Spacer(),
                            Text('تعريف بالمدرس',style: theme.textTheme.titleSmall,)
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.play_circle,color: theme.canvasColor,),
                            const Spacer(),
                            Text('الدرس الاول',style: theme.textTheme.titleSmall,)
                          ],
                        ),
                        const SizedBox(height: 10.0,),
                      ],
                    ),
                  ),
                  fallback: (context)=>Container(),
                ),
              ],
            )
        );
      },
    );
  }
}