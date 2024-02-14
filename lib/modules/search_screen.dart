import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
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
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context, state) {},
      builder: (context, state) {
        var list = AppCubit.get(context).search;
        bool startSearching = false;
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.0,
            bottomOpacity: 0.7,
            elevation: 2.0,
            shadowColor: Colors.grey,
            shape: ContinuousRectangleBorder(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: IconButton(
                  onPressed: (){Navigator.pop(context);},
                  icon: Icon(Icons.arrow_back_ios_rounded,size:30.0,)
              ),
            ),
            title: TextField(
              controller: searchController,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: 'ادخل اسم المدرس او المادة',
                hintStyle: Theme.of(context).textTheme.titleSmall,
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              onChanged: (value){
                setState(() {
                  startSearching = true;
                });
              },
              onSubmitted: (value) {
                AppCubit.get(context).getSearch(value);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right:11.0),
                child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.filter_alt_outlined,size:30.0,)
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Expanded(
              child: ConditionalBuilder(
                condition: list.length > 0,
                builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => BuiltArticleItem(list[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: list.length,
                ),
                fallback: (context) =>startSearching?Center(child: CircularProgressIndicator()):Container(),
              ),
            )
          ),
        );
      },
    );
  }
}