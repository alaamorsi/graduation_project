import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                ),
                child: IconButton(
                  onPressed: (){navigateTo(context,const EditProfileScreen());},
                  icon: Icon(Icons.edit_rounded,size: 25,color: Theme.of(context).primaryColor),
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
                backgroundColor: Colors.transparent,
                radius:63,
                backgroundImage: AssetImage("Assets/avatar1.png",),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          //data
          dataLabel('first name', 'first name', theme.primaryColor),
          const SizedBox(height: 10,),
          dataLabel('email', 'user@gmail.com', theme.primaryColor),
          const SizedBox(height: 10,),
          dataLabel('bio', 'if you fight you will win', theme.primaryColor),
        ],
      ),
    );
  }
  Widget dataLabel(String title,String name,Color color){
    return Column(
      children: [
         Row(
          children: [
            Text(title,style: const TextStyle(fontSize: 10.0,color: Colors.grey),),
          ],
        ),
        Card(
          color: color,
          elevation: 4,
          child: ListTile(
            leading: Text(name,
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
