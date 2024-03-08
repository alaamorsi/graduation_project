import 'dart:convert';
import 'dart:typed_data';

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
    Uint8List picture = base64Decode(CacheHelper.getData(key: 'profilePicture'));
    imageProvider = MemoryImage(picture);
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
                          backgroundImage: imageProvider,
                        ),
                        InkWell(
                          onTap: (){navigateTo(context,const EditProfileScreen());},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                            ),
                            child: const Icon(Icons.edit_rounded,size: 15,color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${CacheHelper.getData(key: 'firstName')} ${CacheHelper.getData(key: 'lastName')}",
                        style: font.copyWith(fontWeight: FontWeight.w800,fontSize: 18.0,color: theme.primaryColorDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(CacheHelper.getData(key: 'email'),
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
              userdata(title: 'Last name', data: CacheHelper.getData(key: 'lastName'), theme: theme),
              const SizedBox(height: 10,),
              userdata(title: 'Email', data: CacheHelper.getData(key: 'email'),noIcon: false,icon: Icons.email_rounded, theme: theme),
              const SizedBox(height: 10,),
              userdata(title: 'bio', data: CacheHelper.getData(key: 'biography')??"", theme: theme),
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
        Text(title,style: font.copyWith(fontSize: 13.0,color: theme.primaryColorDark.withOpacity(0.7)),),
        SizedBox(height: 5.0,),
        ListTile(
          leading: Text(data,
            style: font.copyWith(fontWeight: FontWeight.bold,fontSize: 17.0,color: theme.primaryColorDark),
          ),
          trailing:noIcon?null:Icon(icon,size: 30,color: theme.primaryColor,),
          shape:OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          textColor: theme.primaryColorLight.withOpacity(.4),
        ),
      ],
    );
  }
}
