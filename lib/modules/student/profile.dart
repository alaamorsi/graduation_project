import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/student/editprofile.dart';
import 'package:graduation_project/shared/components.dart';
import '../../layout/student/cubit/cubit.dart';
import '../../layout/student/cubit/states.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        // var cubit = StudentCubit.get(context);
        var theme  = Theme.of(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //edit button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              topRight: Radius.circular(3.0),
                              bottomLeft: Radius.circular(3.0),
                            ),
                        ),
                        child: IconButton(
                            onPressed: (){
                              navigateTo(context,const EditProfileScreen());
                            },
                            icon:const Icon(Icons.edit_rounded,color: Colors.white,)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3.0,),
                  //Student Image
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius:63,
                        backgroundImage: AssetImage("Assets/teacher.png",),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  //data
                  const Card(
                    elevation: 4,
                    child: ListTile(
                      trailing: Text("احمد معبد عيسي",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Card(
                    elevation: 4,
                    child: ListTile(
                      trailing: Text("am5790@fayoum.edu.eg",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Card(
                    elevation: 4.0,
                    child: ListTile(
                      trailing: Text("الصف الثالث الاعدادي",
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
