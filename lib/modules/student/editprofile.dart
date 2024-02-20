import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../layout/student/cubit/cubit.dart';
import '../../layout/student/cubit/states.dart';
import '../../shared/components.dart';
import '../../shared/constant.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController  statusController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        var theme = Theme.of(context);
        File? imageFile;
        imageFromGallery() async {
          final getImage = await ImagePicker().pickImage(source: ImageSource.gallery);
          setState(() {
            if(getImage != null){
              imageFile = File(getImage.path);
            }
          });
        }

        imageFromCamera() async {
          final getImage = await ImagePicker().pickImage(source: ImageSource.camera);
          setState(() {
            if(getImage != null){
              imageFile = File(getImage.path);
            }
          });
        }
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: defaultAppBar(
              context: context,
              leadingIcon: Icons.arrow_back_ios_new_rounded,
              leadingFunction: (){Navigator.pop(context);},
              title: Text("تعديل الملف الشخصي",style: font.copyWith(color: Colors.white,fontSize: 20.0),),
              atEnd: false,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("حفظ",style: font.copyWith(color: Colors.white,fontSize: 16.0),)),
                        ),
                        const Spacer(),
                        Text("تعديل الملف الشخصي",style: font.copyWith(color: theme.cardColor,fontSize: 18.0),)
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
                                image: imageFile != null?
                                FileImage(imageFile!):
                                const AssetImage('Assets/teacher.png') as ImageProvider ,fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              IconButton(
                                onPressed: () {
                                  imageFromGallery();
                                },
                                icon: const Icon(Icons.add_a_photo_rounded,color: Colors.white,size: 33),),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 21.0,),
                    //data
                    Text("الأسم الكامل",style: font.copyWith(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                      controller: nameController,
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
                      label: 'الاسم',),
                    const SizedBox(height: 10.0),
                    Text("الحالة الدراسية",style: font.copyWith(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                        controller: statusController,
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
                        label: 'المستوي الدراسي',),
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
