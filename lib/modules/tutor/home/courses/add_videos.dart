import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_cubit.dart';
import '../../../../layout/tutor/tutor_cubit/instructor_states.dart';
import '../../../../shared/component/constant.dart';

class AddVideos extends StatelessWidget {
  const AddVideos({super.key});

    @override
  Widget build(BuildContext context) {
      return BlocConsumer<InstructorCubit, InstructorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = InstructorCubit.get(context);
          var theme = Theme.of(context);
          return Scaffold(
            appBar: secondAppbar(
              context: context,
              title: "Add Course",
              hasAction: true,
              actionIcon: InkWell(
                onTap: (){
                },
                child: Padding(padding: const EdgeInsets.only(right:10.0),
                  child:Container(
                    height: 43,
                    padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 3),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                    ),
                    child: Text("Finish",style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),)
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  Text(
                    "Add videos",
                    style: font.copyWith(color: theme.primaryColorDark,fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      InkWell(
                        onTap: () async{
                          await cubit.pikeVideoFromCamera();
                        },
                        child: Padding(padding: const EdgeInsets.all(10.0),
                          child:Container(
                              height: 43,
                              padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Add",style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                                  const SizedBox(width: 10,),
                                  Icon(Icons.camera,color: theme.primaryColor,size: 30)
                                ]
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async{
                          await cubit.pikeVideoFromGallery();
                        },
                        child: Padding(padding: const EdgeInsets.all(10.0),
                          child:Container(
                              height: 43,
                              padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Add",style: font.copyWith(color: theme.primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                                  const SizedBox(width: 10,),
                                  Icon(Icons.video_collection,color: theme.primaryColor,size: 30)
                                ]
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 10,
                    children: cubit.videos.isNotEmpty?
                    cubit.videos.map((e) =>
                      Container(
                        height: 150.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: theme.canvasColor
                        ),
                        child:const Center(child: Text("Video")),
                      ),
                    ).toList(): [],
                  ),
                ],
              ),
            ),
          );
        },
      );
  }
}