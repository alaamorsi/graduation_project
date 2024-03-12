import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(context: context, title:"Theme",),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  //app mode
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child:mode?
                        Icon(Icons.brightness_high_rounded,size: 25,color:theme.primaryColor,):
                        Icon(Icons.brightness_4_outlined,size: 25,color:theme.primaryColor,),
                      ),
                      const SizedBox(width: 20,),
                      Text("Mode",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                      const Spacer(),
                      Switch(
                        value: mode,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: theme.primaryColorDark,
                        activeColor: theme.primaryColor,
                        onChanged: (value) {
                          appCubit.changeAppMode();
                        },
                      ),
                    ],
                  ),
                  newDivider(),
                  //theme
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                        ),
                        child: Icon(Icons.imagesearch_roller_rounded,size: 25,color:theme.primaryColor),
                      ),
                      const SizedBox(width: 20,),
                      Text("Theme",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                      const Spacer(),
                      ],
                  ),
                  const SizedBox(height: 20,),
                  Wrap(
                    children: [
                      themeItem(title: "Orange (Safe)", icon: Icons.headset, cardColor: HexColor("#FF4500"), tap: (){appCubit.changeTheme(1);}),
                      themeItem(title: "Green (Natural)", icon: Icons.eco_rounded,cardColor: HexColor("#056608"), tap: (){appCubit.changeTheme(2);}),
                      themeItem(title: "Blue (Fly)", icon: Icons.flight_takeoff_rounded,cardColor: HexColor("#1589FF"), tap: (){appCubit.changeTheme(3);}),
                      themeItem(title: "Purple (Peace)", icon: Icons.yard_rounded,cardColor: HexColor("#9933ff"), tap: (){appCubit.changeTheme(4);}),
                    ],
                  )
                ]
            ),
          ),
        );
      },
    );
  }
  Widget themeItem({
    required String title,
    required Color cardColor,
    required IconData icon,
    required void Function() tap,
  }){
   return Padding(
     padding: const EdgeInsets.symmetric(vertical: 10.0),
     child: InkWell(
       onTap: tap,
       child: Container(
         padding: const EdgeInsets.all(10),
         height: 70,
         width: double.infinity,
         decoration: BoxDecoration(
           color: cardColor.withOpacity(.2),
           borderRadius: const BorderRadius.all(Radius.circular(15)),
         ),
         child: Row(
           children: [
             Icon(icon,size: 40,color:cardColor),
             const SizedBox(width: 20,),
             Text(title,style: font.copyWith(fontSize: 18.0,color: Colors.white,),),
           ],
         ),
       ),
     ),
   );
  }
}