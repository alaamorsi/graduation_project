import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/layout/student/cubit/states.dart';
import 'package:graduation_project/modules/student/profile/edit_profile.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    var theme  = Theme.of(context);
    return BlocConsumer<StudentCubit,StudentStates>(
      builder: (context , state) {
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
                          backgroundColor: theme.canvasColor.withOpacity(.3),
                          radius:50.0,
                          backgroundImage: CacheHelper.getData(key: 'profilePicture')!=null? NetworkImage(CacheHelper.getData(key: 'profilePicture')) as ImageProvider<Object> :  const AssetImage("Assets/profile_icon_S.png",),
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
                        style: font.copyWith(fontWeight: FontWeight.w800,fontSize: 18.0,color: theme.primaryColorDark),
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
              userdata(title: 'First name', data: CacheHelper.getData(key: 'firstName'), theme: theme),
              const SizedBox(height: 10,),
              userdata(title: 'Last name', data: 'Ahmed', theme: theme),
              const SizedBox(height: 10,),
              userdata(title: 'Email', data: 'useremail@gmail.com',noIcon: false,icon: Icons.email_rounded, theme: theme),
              const SizedBox(height: 10,),
              userdata(title: 'bio', data: 'there is no battle without lose', theme: theme),
            ],
          ),
        );
      }, listener: (BuildContext context, StudentStates state) { },
    );
  }
  Widget userdata({
    required String title,
    required String data,
    IconData? icon,
    bool noIcon = true,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: font.copyWith(fontSize: 13.0,color: Colors.grey),),
        Card(
          child: ListTile(
            leading: Text(data,
              style: font.copyWith(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.white),
            ),
            trailing:noIcon?null:Icon(icon,size: 30,color: theme.primaryColor,),
            shape:OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 0.3,
              ),
            ),
            textColor: theme.primaryColorLight.withOpacity(.4),
          ),
        ),
      ],
    );
  }
}
