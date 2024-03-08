import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../../layout/student/cubit/cubit.dart';
import '../../../layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme = Theme.of(context);
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: secondAppbar(context: context, title: 'edit profile'),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //edit button
                    Row(
                      children: [
                        Container(
                          height: 40.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextButton(
                              onPressed: ()async{
                                // List<int> imageBytes = await cubit.profileImage!.readAsBytes();
                                // String base64Image = base64Encode(imageBytes);
                                // CacheHelper.saveData(key: 'profilePicture', value: base64Image);
                                if(formKey.currentState!.validate())
                                  {
                                    cubit.updateUserData(firstName: firstNameController.text,lastName: lastNameController.text,bio: bioController.text);
                                  }
                              },
                              child: Text("save",style: font.copyWith(color: Colors.white,fontSize: 16.0),)),
                        ),
                        const Spacer(),
                        Text("edit profile",style: font.copyWith(color: theme.cardColor,fontSize: 18.0),)
                      ],
                    ),
                    const SizedBox(height: 21.0,),
                    //Student Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120.0,
                          width: 120.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: cubit.profileImage != null?
                                FileImage(cubit.profileImage!):
                                imageProvider ,fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: theme.cardColor,
                                    child: const Icon(Icons.add_a_photo_rounded,color: Colors.white,size: 25)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 21.0,),
                    //data
                    Text("First Name",style: font.copyWith(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                      controller: firstNameController,
                      type: TextInputType.text,
                      therePrefix: false,
                      thereSuffix: false,
                      radius: 10.0,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'رجاءً ادخل الاسم';
                        }
                        return null;
                      },
                      label: 'First Name',
                    onSubmit: (String? value)
                        {
                              cubit.updateFirstName = CacheHelper.getData(key: 'firstName') != value.toString();
                        }

                    ),
                    const SizedBox(height: 10.0,),
                    //data
                    Text("Last Name",style: font.copyWith(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                      controller: lastNameController,
                      type: TextInputType.text,
                      therePrefix: false,
                      thereSuffix: false,
                      radius: 10.0,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'رجاءً ادخل الاسم';
                        }
                        return null;
                      },
                      label: 'Last Name',
                        onSubmit: (String? value)
                        {
                          cubit.updateLastName = CacheHelper.getData(key: 'lastName') != value.toString();
                        }
                    ),
                    const SizedBox(height: 10.0),
                    Text("Bio",style: font.copyWith(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                        controller: bioController,
                        type: TextInputType.emailAddress,
                        therePrefix: false,
                        thereSuffix: false,
                        radius: 10.0,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'ادخل المستوي الدراسي المسجل فيه';
                          }
                          return null;
                        },
                        label: 'Bio',
                        onSubmit: (String? value)
                        {
                          cubit.updateBio = CacheHelper.getData(key: 'biography') != value.toString();
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
