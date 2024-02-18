import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared/components.dart';
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
        List<String> selectedItems = [];

        void showSearchFilter() async
        {
          final List<String> results = await showDialog(
              context: context,
              builder: (BuildContext context){
                return const MultiSelect();
              }
          );
          setState(() {
            selectedItems = results;
          });
        }

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
                  onPressed: (){
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
                      showSearchFilter();
                    },
                    icon: const Icon(Icons.filter_alt_outlined,size:30.0,)
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: list.isNotEmpty,
                    builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => BuiltArticleItem(list[index], context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: list.length,
                    ),
                    fallback: (context) =>startSearching?const Center(child: CircularProgressIndicator()):Container(),
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


class MultiSelect extends StatefulWidget {
  const MultiSelect({super.key});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final eduLevel=[
    'الثانوي',
    'الإعدادي',
    'الإبتدائي',
  ];
  final subjects=[
    'عربي',
    'انجليزي',
    'رياضيات',
    'درسات',
    'علوم',
    'فرنساوي',
    'ايطالي',
    'الماني',
    'تاريخ',
    'جغرافيه',
    'كمياء',
    'فيزياء',
    'احياء',
    'علم نفس',
    'فلسفه',
  ];
  final levelSelections=[
    false,
    false,
    false,
  ];
  final subSelections=[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> selectedItems =[];

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if(isSelected){
        selectedItems.add(itemValue);
      }
      else{
        selectedItems.remove(itemValue);
      }
    });
  }

  void cansel(){
    Navigator.pop(context);
  }
  void submit(){
    Navigator.pop(context,selectedItems);
  }

  @override
  Widget build(BuildContext context) {


    return AlertDialog(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      title: Row(
        mainAxisAlignment:MainAxisAlignment.end,
        children: [
          Text('فلترة البحث ؟',style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('المرحلة التعليمية',style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),
            ),
            ConditionalBuilder(
              condition: true,
              builder:(context)=> Table(
                children: [
                  TableRow(children: [
                    chooses(context, 0, eduLevel, levelSelections),
                    chooses(context, 1, eduLevel, levelSelections),
                    chooses(context, 2, eduLevel, levelSelections),
                  ]),
                ],
              ),
              fallback: (context)=>Container(),
            ),
            const SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){},
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('المواد الدراسية',style: Theme.of(context).textTheme.titleMedium,),
                  ],
                ),
              ),
            ),
            ConditionalBuilder(
              condition: true,
              builder:(context)=> Table(
                children: [
                  TableRow(children: [
                      chooses(context, 0, subjects, subSelections),
                      chooses(context, 1, subjects, subSelections),
                      chooses(context, 2, subjects, subSelections),
                    ]),
                  TableRow(children: [
                    chooses(context, 3, subjects, subSelections),
                    chooses(context, 4, subjects, subSelections),
                    chooses(context, 5, subjects, subSelections),
                  ]),
                  TableRow(children: [
                    chooses(context, 6, subjects, subSelections),
                    chooses(context, 7, subjects, subSelections),
                    chooses(context, 8, subjects, subSelections),
                  ]),
                  TableRow(children: [
                    chooses(context, 9, subjects, subSelections),
                    chooses(context, 10, subjects, subSelections),
                    chooses(context, 11, subjects, subSelections),
                  ]),
                  TableRow(children: [
                    chooses(context, 12, subjects, subSelections),
                    chooses(context, 13, subjects, subSelections),
                    chooses(context, 14, subjects, subSelections),
                  ]),
                ],
              ),
              fallback: (context)=>Container(),
            ),
            const SizedBox(height: 10.0,),
          ]
        ),
      ),
      actions: [Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: cansel,
              child: const Text('الغاء')
            ),
            ElevatedButton(
              onPressed: submit,
              child: const Text('تطبيق')
            ),
          ],
        ),],
    );
  }

  Widget chooses(BuildContext context,int index,List<String> list,List<bool> isSelect)=>
      FilterChip(
          showCheckmark: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),),
          label: Text(list[index]),
          labelStyle: Theme.of(context).textTheme.titleSmall,
          selected: isSelect[index],
          backgroundColor: Colors.grey,
          selectedColor: Theme.of(context).cardColor,
          onSelected: (bool select){
            setState(() {
              itemChange(list[index], select);
              isSelect[index] = !isSelect[index];
            });
          }
      );
}