import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/student/cubit/cubit.dart';
import '../../../layout/student/cubit/states.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../shared/component/constant.dart';
import '../../../shared/network/cache_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool ch1=false,ch2=false,ch3=false,wci =false;
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme = Theme.of(context);
        var cubit = StudentCubit.get(context);
        firstNameController.text =CacheHelper.getData(key: 'firstName');
        lastNameController.text = CacheHelper.getData(key: 'lastName');
        bioController.text =CacheHelper.getData(key: 'biography')??"";
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
                    if(state is UpdateUserDataLoadingState)const LinearProgressIndicator(),
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
                                if(wci){
                                  await cubit.updateUserProfileImage(imageFile: cubit.profileImage);
                                  List<int> imageBytes = await cubit.profileImage!.readAsBytes();
                                  String base64Image = base64Encode(imageBytes);
                                  await CacheHelper.saveData(key: 'profileStr', value: base64Image);
                                  cubit.getImage();
                                  setState(() {
                                    wci =false;
                                  });
                                }
                                if(formKey.currentState!.validate()) {
                                  await cubit.updateUserData(
                                    updateFirstName: ch1,
                                    updateLastName: ch2,
                                    updateBio: ch3,
                                    newFirstName: firstNameController.text,
                                    newLastName: lastNameController.text,
                                    newBio: bioController.text,
                                  );
                                  await CacheHelper.saveData(key: 'firstName', value: firstNameController.text);
                                  await CacheHelper.saveData(key: 'lastName', value: lastNameController.text);
                                  await CacheHelper.saveData(key: 'biography', value: bioController.text);
                                  cubit.getUser();
                                }
                                Navigator.pop(context);
                              },
                              child: Text("save",style: font.copyWith(color: Colors.white,fontSize: 16.0),)),
                        ),
                        const Spacer(),
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
                            color:theme.canvasColor.withOpacity(.4),
                            image: DecorationImage(
                                image: cubit.profileImage != null?
                                FileImage(cubit.profileImage!):
                                cubit.imageProvider,fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              IconButton(
                                onPressed: () {
                                  wci=true;
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
                    Text("First Name",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    defaultFormField(
                      controller: firstNameController,
                      type: TextInputType.text,
                      therePrefix: false,
                      thereSuffix: false,
                      radius: 30,
                      validate: (String? value) {
                        setState(() {
                          ch1 = CacheHelper.getData(key: 'firstName')!= value.toString();
                        });
                        return null;
                      },
                      label: 'First Name',
                    ),
                    const SizedBox(height: 10.0,),
                    //data
                    Text("Last Name",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    defaultFormField(
                      controller: lastNameController,
                      type: TextInputType.text,
                      therePrefix: false,
                      thereSuffix: false,
                      radius: 30,
                      validate: (String? value) {
                        setState(() {
                          ch2 = CacheHelper.getData(key: 'lastName')!=value.toString();
                        });
                        return null;
                      },
                      label: 'Last Name',
                    ),
                    const SizedBox(height: 10.0),
                    Text("Bio",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    defaultFormField(
                        controller: bioController,
                        type: TextInputType.emailAddress,
                        therePrefix: false,
                        thereSuffix: false,
                        radius: 30,
                        validate: (String? value) {
                          setState(() {
                            ch3 = CacheHelper.getData(key: 'biography')!=value.toString();
                          });
                          return null;
                        },
                        label: 'Bio',
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
