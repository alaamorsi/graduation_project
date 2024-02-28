import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var theme  = Theme.of(context);
    return Padding(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag:"hero",
                child: CircleAvatar(
                  radius: 67,
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  child: const CircleAvatar(
                    radius:63,
                    backgroundImage: AssetImage("Assets/teacher.png",),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          //data
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('user name',style: TextStyle(fontSize: 10.0,color: Colors.grey),),
              SizedBox(width: 10.0,)
            ],
          ),
          Card(
            color: theme.appBarTheme.backgroundColor,
            elevation: 4,
            child: const ListTile(
              trailing: Text('user name',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('email',style: TextStyle(fontSize: 10.0,color: Colors.grey),),
              SizedBox(width: 10.0,)

            ],
          ),
          Card(
            color: theme.appBarTheme.backgroundColor,
            elevation: 4,
            child: const ListTile(
              leading: Text('user@gmail.com',
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('educational states',style: TextStyle(fontSize: 10.0,color: Colors.grey),),
              SizedBox(width: 10.0,)
            ],
          ),
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
    );
  }
}
