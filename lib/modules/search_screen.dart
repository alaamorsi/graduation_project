import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
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
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70.0),
                bottomRight: Radius.circular(70.0),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 11.0),
              child: IconButton(
                  onPressed: (){
                    if(AppCubit.get(context).isFilterOpen)
                      {
                        AppCubit.get(context).closeSearchFilter();
                      }
                    Navigator.pop(context);
                    },
                  icon: const Icon(Icons.arrow_back_ios_rounded,size:30.0,)
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
                    onPressed: (){
                      if(!AppCubit.get(context).isFilterOpen)
                      {
                        AppCubit.get(context).showSearchFilter(context);
                      }
                      else
                      {
                        AppCubit.get(context).closeSearchFilter();
                      }
                    },
                    icon: const Icon(Icons.filter_alt_outlined,size:30.0,)
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConditionalBuilder(
              condition: list.isNotEmpty,
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => BuiltArticleItem(list[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: list.length,
              ),
              fallback: (context) =>startSearching?const Center(child: CircularProgressIndicator()):Container(),
            )
          ),
        );
      },
    );
  }
}