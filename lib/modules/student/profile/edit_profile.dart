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
  void initState() {
    super.initState();
    StudentCubit.get(context).profileImage = null;
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme = Theme.of(context);
        var cubit = StudentCubit.get(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            toolbarHeight: 70.0,
            iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
            titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
            leading:Padding(
              padding: const EdgeInsets.only(
                  left: 14.0,top: 14.0,bottom: 14.0
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 7.0),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                ),
                child: IconButton(
                  onPressed: (){
                    cubit.getUser();
                    cubit.getImage();
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,size: 20,color: Theme.of(context).primaryColor,),
                ),
              ),
            ),
            title: const Text("Edit profile"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is UpdateUserDataLoadingState ||  state is UpdateProfileImageLoadingState )const Padding(padding: EdgeInsets.all(11.0), child: LinearProgressIndicator(),),
                    //Edit Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        //Student Image
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:theme.canvasColor.withOpacity(.4),
                              image: DecorationImage(
                                image: cubit.profileImage != null?
                                FileImage(cubit.profileImage!):
                                cubit.imageProvider,fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                IconButton(
                                  onPressed: () async{
                                    await cubit.getProfileImage();
                                    if(cubit.profileImage != null){
                                      int? response = await cubit.updateUserProfileImage(imageFile: cubit.profileImage);
                                      if(response == 200){
                                        List<int> imageBytes = await cubit.profileImage!.readAsBytes();
                                        String base64Image = base64Encode(imageBytes);
                                        await CacheHelper.saveData(key: 'profileStr', value: base64Image);
                                        cubit.getImage();
                                        showToast(text: "Image has been saved successfully", state: ToastStates.success);
                                      }
                                      else if(response == 401){
                                        showToast(text: "Unauthorized access", state: ToastStates.error);
                                      }
                                      else{
                                        showToast(text: "Something went wrong", state: ToastStates.error);
                                      }
                                    }
                                  },
                                  icon: CircleAvatar(
                                      backgroundColor: theme.cardColor,
                                      child: const Icon(Icons.add_a_photo_rounded,color: Colors.white,size: 25)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(height: 15.0,),
                    //Edit First Name
                    Text("First Name",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(CacheHelper.getData(key: 'firstName')),
                          IconButton(
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text("First name",style: font.copyWith(color: theme.primaryColor,fontSize: 22.0)),
                                            editFormField(
                                                context: context,
                                                controller: firstNameController,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'name can not be empty!';
                                                  }
                                                  return null;
                                                },
                                                label: CacheHelper.getData(key: 'firstName')
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: (){Navigator.pop(context);},
                                                    child: Text('back',style: font.copyWith(color: theme.primaryColor,fontSize: 15.0),)
                                                ),
                                                const SizedBox(width: 5,),
                                                ElevatedButton(
                                                    style:  ButtonStyle(
                                                        backgroundColor: MaterialStatePropertyAll(theme.primaryColor)
                                                    ),
                                                    onPressed: () async{
                                                      var response = await cubit.updateUserData(
                                                        updateFirstName: true,
                                                        updateLastName: false,
                                                        updateBio: false,
                                                        newFirstName: firstNameController.text,
                                                      );
                                                      if(response ==200){
                                                        await CacheHelper.saveData(key: 'firstName', value: firstNameController.text);
                                                        showToast(text: "Data has been updated successfully", state: ToastStates.success);
                                                      }
                                                      else if(response ==401){
                                                        showToast(text: "Unauthorized access", state: ToastStates.error);
                                                      }
                                                      else{
                                                        showToast(text: "Something went wrong", state: ToastStates.error);
                                                      }
                                                    },
                                                    child: Text('submit',style: font.copyWith(color: Colors.white,fontSize: 16.0),)
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                    );
                                  }
                              );
                            },
                            icon: Icon(Icons.edit,color: theme.primaryColor,size: 25,)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0,),
                    //Edit Last Name
                    Text("Last Name",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(CacheHelper.getData(key: 'lastName')),
                          IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context){
                                      return Padding(
                                        padding: const EdgeInsets.all(11.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Last name",style: font.copyWith(color: theme.primaryColor,fontSize: 22.0)),
                                            editFormField(
                                                context: context,
                                                controller: lastNameController,
                                                validate: (String? value) {
                                                  if (value!.isEmpty) {
                                                    return 'name can not be empty!';
                                                  }
                                                  return null;
                                                },
                                                label: CacheHelper.getData(key: 'lastName')
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: (){Navigator.pop(context);},
                                                    child: Text('back',style: font.copyWith(color: theme.primaryColor,fontSize: 15.0),)
                                                ),
                                                const SizedBox(width: 5,),
                                                ElevatedButton(
                                                    style:  ButtonStyle(
                                                        backgroundColor: MaterialStatePropertyAll(theme.primaryColor)
                                                    ),
                                                    onPressed: () async{
                                                      var response = await cubit.updateUserData(
                                                        updateFirstName: false,
                                                        updateLastName: true,
                                                        updateBio: false,
                                                        newLastName: lastNameController.text,
                                                      );
                                                      if(response ==200){
                                                        await CacheHelper.saveData(key: 'lastName', value: lastNameController.text);
                                                        showToast(text: "Data has been updated successfully", state: ToastStates.success);
                                                      }
                                                      else if(response ==401){
                                                        showToast(text: "Unauthorized access", state: ToastStates.error);
                                                      }
                                                      else{
                                                        showToast(text: "Something went wrong", state: ToastStates.error);
                                                      }
                                                    },
                                                    child: Text('submit',style: font.copyWith(color: Colors.white,fontSize: 16.0),)
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },
                              icon: Icon(Icons.edit,color: theme.primaryColor,size: 25,)
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    //Edit Bio
                    Text("Bio",style: font.copyWith(color: Colors.grey,fontSize: 11.0),),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(CacheHelper.getData(key: 'biography')),
                          IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Padding(
                                      padding: const EdgeInsets.all(11.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("bio",style: font.copyWith(color: theme.primaryColor,fontSize: 22.0)),
                                          editFormField(
                                              context: context,
                                              controller: bioController,
                                              validate: (String? value) {
                                                return null;
                                              },
                                              label: CacheHelper.getData(key: 'biography')
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: (){Navigator.pop(context);},
                                                  child: Text('back',style: font.copyWith(color: theme.primaryColor,fontSize: 15.0),)
                                              ),
                                              const SizedBox(width: 5,),
                                              ElevatedButton(
                                                  style:  ButtonStyle(
                                                      backgroundColor: MaterialStatePropertyAll(theme.primaryColor)
                                                  ),
                                                  onPressed: () async{
                                                    var response = await cubit.updateUserData(
                                                      updateFirstName: false,
                                                      updateLastName: false,
                                                      updateBio: true,
                                                      newBio: bioController.text,
                                                    );
                                                    if(response ==200){
                                                      await CacheHelper.saveData(key: 'biography', value: bioController.text);
                                                      showToast(text: "Data has been updated successfully", state: ToastStates.success);
                                                    }
                                                    else if(response ==401){
                                                      showToast(text: "Unauthorized access", state: ToastStates.error);
                                                    }
                                                    else{
                                                      showToast(text: "Something went wrong", state: ToastStates.error);
                                                    }
                                                  },
                                                  child: Text('submit',style: font.copyWith(color: Colors.white,fontSize: 16.0),)
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              },
                              icon: Icon(Icons.edit,color: theme.primaryColor,size: 25,)
                          ),
                        ],
                      ),
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
