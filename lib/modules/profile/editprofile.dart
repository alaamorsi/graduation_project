import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/profile/profile.dart';

import '../../layout/student/cubit/cubit.dart';
import '../../layout/student/cubit/states.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';

class editprofile_screen extends StatefulWidget {
  const editprofile_screen({Key? key}) : super(key: key);

  @override
  _editprofile_screenState createState() => _editprofile_screenState();
}

class _editprofile_screenState extends State<editprofile_screen> {
  TextEditingController namecontrol = TextEditingController();
  TextEditingController  emillecontrol = TextEditingController();
  TextEditingController  statillecontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // appBar: defaultAppBar(context: context, leadingIcon: null, leadingFunction: () {  },),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>profile_screen(),),);

                          },
                          style: ButtonStyle(

                          ),
                          icon:Icon(Icons.save,color: Colors.white,)

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
                    defaultFormField(
                        controller: namecontrol,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل الاسم';
                          }
                        },
                        label: 'الاسم',
                        suffixIcon: Icons.account_box_rounded),
                    SizedBox(height: 10.0),
                    defaultFormField(
                        controller: emillecontrol,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'رجاءً ادخل البريد الالكتروني الصحيح';
                          }
                        },
                        label: 'البريد الإلكتروني',
                        suffixIcon: Icons.email_outlined),
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
