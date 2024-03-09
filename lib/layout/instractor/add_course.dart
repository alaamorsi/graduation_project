import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../modules/cubit/cubit.dart';
import '../../modules/cubit/states.dart';
import '../../shared/component/components.dart';

class add_cours extends StatelessWidget {
  add_cours({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController name22Controller = TextEditingController();
  TextEditingController name222Controller = TextEditingController();
  TextEditingController name2222Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.0,
            bottomOpacity: 0.7,
            elevation: 2.0,
            shadowColor: HexColor("#666666"),
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 30.0,
                  )),
            ),
            title: Center(
              child: Text(
                'إنشاء صـــف',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "نوع الصـــــف",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          therePrefix: false,
                          thereSuffix: false,
                          radius: 10.0,
                          label: '',
                          validate: null,


                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: defaultFormField(
                          controller: name22Controller,
                          type: TextInputType.text,
                          therePrefix: false,
                          thereSuffix: false,
                          radius: 10.0,
                          label: '',
                          validate: null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "نوع الماده",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: defaultFormField(
                            controller: name222Controller,
                            type: TextInputType.text,
                            therePrefix: false,
                            thereSuffix: false,
                            radius: 10.0,
                            label: 'الدخل اسم الماده',
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return ' رجاء ادخل اسم الماده!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            " الصف الدراسي",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: defaultFormField(
                            controller: name2222Controller,
                            type: TextInputType.text,
                            therePrefix: false,
                            thereSuffix: false,
                            radius: 10.0,
                            label: 'ادخل الصف الدراسي',
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'ادخل الصف الدراسي!';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "تعريف بالمدرس (فديوا تعريفي بالمدرس)",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_upward_outlined),
                          label: Text('اضـف فديوا'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            
                          backgroundColor: Colors.blue,
                          alignment: Alignment.centerRight,
            
            
                        ),
            
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column (
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "تعريف بالمحتوي (فديوا تعريفي بالمحتوي)",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_upward_outlined),
                        label: Text('اضـف فديوا'),
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            
                          backgroundColor: Colors.blue,
                          alignment: Alignment.centerRight,
            
            
                        ),
            
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
