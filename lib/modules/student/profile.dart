import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/cubit/states.dart';
import 'package:graduation_project/modules/student/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme  = Theme.of(context);
        var cubit = LoginCubit.get(context);
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
                            color: theme.appBarTheme.backgroundColor,
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
                      Hero(
                        tag:"hero",
                        child: CircleAvatar(
                          radius:63,
                          backgroundImage: AssetImage("Assets/teacher.png",),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  //data
                   Card(
                     color: theme.appBarTheme.backgroundColor,
                    elevation: 4,
                    child: ListTile(
                      trailing: Text(cubit.userData.firstName+cubit.userData.lastName,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Card(
                     color: theme.appBarTheme.backgroundColor,
                     elevation: 4,
                    child: ListTile(
                      trailing: Text(cubit.userData.email,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                   Card(
                     color: theme.appBarTheme.backgroundColor,
                    elevation: 4.0,
                    child: const ListTile(
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
