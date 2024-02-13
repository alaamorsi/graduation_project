import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class searshscreen extends StatefulWidget {

  @override
  _searshscreenState createState() => _searshscreenState();
}

class _searshscreenState extends State<searshscreen> {
  TextEditingController Search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context, state) {},
      builder: (context, state) {
        var list=AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: Search,
                  type: TextInputType.text,
                  onChanged: (value) {
                    AppCubit.get(context).getSearch(value);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'رجاءً ادخل كلمه البحث';
                    }
                  },
                  label: "ابحث",
                  suffixIcon:  Icons.search,


                ),
              ),
              Expanded(child: buldarticalitm(list,context)),
            ],
          ),
        );
      },
    );
  }
}