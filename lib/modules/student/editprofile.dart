import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/student/cubit/cubit.dart';
import '../../layout/student/cubit/states.dart';
import '../../shared/components.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController namecontrol = TextEditingController();
  TextEditingController  emillecontrol = TextEditingController();
  TextEditingController  statillecontrol = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCubit,StudentStates>(
      listener: (context,state) {},
      builder:(context,state){
        // var cubit = StudentCubit.get(context);
        var theme = Theme.of(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: defaultAppBar(
              context: context,
              leadingIcon: Icons.arrow_back_ios_new_rounded,
              leadingFunction: (){Navigator.pop(context);},
              title: Center(child: Text("تعديل الملف الشخصي",style: theme.textTheme.titleMedium,)),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
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
                              child: const Text("حفظ",style: TextStyle(color: Colors.white,fontSize: 16.0),)),
                        ),
                        const Spacer(),
                        Text("تعديل الملف الشخصي",style: TextStyle(color: theme.cardColor,fontSize: 18.0),)
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
                            image: const DecorationImage(
                                image: AssetImage("Assets/teacher.png"),fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 21.0,),
                    //data
                    const Text("الأسم الكامل",style: TextStyle(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                      controller: namecontrol,
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
                    const Text("الحالة الدراسية",style: TextStyle(color: Colors.grey,fontSize: 10.0),),
                    defaultFormField(
                        controller: emillecontrol,
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
