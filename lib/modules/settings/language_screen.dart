import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/cubit/cubit.dart';
import 'package:graduation_project/modules/cubit/states.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appCubit = AppCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: secondAppbar(context: context, title:"language".tr,),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      appCubit.changeAppLanguage('ar');
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          height: 70,
                          width: screenWidth-40,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child:Text("العربية",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                        ),
                      ],
                    ),
                  ),
                  newDivider(),
                  InkWell(
                    onTap: (){
                      appCubit.changeAppLanguage('en');
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          height: 70,
                          width: screenWidth-40,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child:Text("English",style: font.copyWith(fontSize: 20.0,color: theme.primaryColorDark),),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        );
      },
    );
  }
}
