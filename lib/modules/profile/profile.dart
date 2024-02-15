import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/profile/editprofile.dart';

import '../../layout/student/cubit/cubit.dart';
import '../../layout/student/cubit/states.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';


class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  _profile_screenState createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
     return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // appBar: defaultAppBar(context: context, logo: appBarLogo),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Container(
                      color: Colors.blueGrey,

                      child: IconButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>editprofile_screen(),),);

                          },
                          style: ButtonStyle(

                          ),
                          icon:Icon(Icons.edit,color: Colors.white,)

                      ),
                    ),
                  ],
                ),

              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius:90,
                      backgroundImage: AssetImage("Assets/teacher.png",),
                    ),

                  ],
                ),

              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        trailing: Text("احمد معبد عيسي",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 15),),

                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.email),
                        trailing: Text("am5790@fayoum.edu.eg",style:TextStyle( fontWeight: FontWeight.bold,fontSize: 15),),

                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: ListTile(
                        leading: Icon(Icons.app_registration),
                        trailing: Text("الصف الثالث الاعدادي",style:TextStyle( fontWeight: FontWeight.bold,fontSize: 15),),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              elevation: 5.0,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index);
              },
              iconSize: 30.0,
              unselectedFontSize: 19.0,
              selectedFontSize: 21.0,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'استكشاف'),
                BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'كورساتي'),
                BottomNavigationBarItem(icon: Icon(Icons.person),label: 'البروفايل'),
              ]
          ),
        );
      },
    );;
  }
}
