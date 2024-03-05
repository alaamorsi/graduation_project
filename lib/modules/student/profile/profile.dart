import 'package:flutter/material.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme  = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          //Student data
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.canvasColor,
                      radius:50.0,
                      backgroundImage: const AssetImage("Assets/avatar1.png",),
                    ),
                    InkWell(
                      onTap: (){navigateTo(context,const EditProfileScreen());},
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: const Icon(Icons.edit_rounded,size: 11,color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("first name",
                    style: font.copyWith(fontWeight: FontWeight.w800,fontSize: 18.0,color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("useremail@gmail.com",
                    style: font.copyWith(fontWeight: FontWeight.w300,fontSize: 13.0,color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          newDivider(),
          userdata(title: 'First name', data: 'Sameh'),
          const SizedBox(height: 10,),
          userdata(title: 'Last name', data: 'Ahmed'),
          const SizedBox(height: 10,),
          userdata(title: 'Email', data: 'useremail@gmail.com',noIcon: false,icon: Icons.email_rounded),
          const SizedBox(height: 10,),
          userdata(title: 'bio', data: 'there is no battle without lose'),
        ],
      ),
    );
  }
  Widget userdata({
    required String title,
    required String data,
    IconData? icon,
    bool noIcon = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: const TextStyle(fontSize: 13.0,color: Colors.grey),),
        TextFormField(
          readOnly: true,
          textAlign: TextAlign.start,
          decoration:InputDecoration(
            filled: true,
            label: Text(data,style: const TextStyle(fontSize: 13.0,fontWeight: FontWeight.bold,color: Colors.black),),
            fillColor: Colors.white,
            suffixIcon:noIcon?null:Icon(icon,size: 30,color: Colors.grey,),
            enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//  Widget dataLabel(String title,String name,Color color){
//     return Column(
//       children: [
//          Row(
//           children: [
//             Text(title,style: const TextStyle(fontSize: 10.0,color: Colors.grey),),
//           ],
//         ),
//         Card(
//           color: color,
//           elevation: 4,
//           child: ListTile(
//             leading: Text(name,
//               style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );
//   }