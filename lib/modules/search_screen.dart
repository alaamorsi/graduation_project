import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:graduation_project/shared/component/components.dart';
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
        void showSearchFilter() async
        {
          final List<String> results = await showDialog(
              context: context,
              builder: (BuildContext context){
                return const MultiSelect();
              }
          );
          setState(() {
            print(results);
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
              decoration: const InputDecoration(
                labelStyle: TextStyle(color:Colors.white),
                hintText: 'ادخل اسم المدرس او المادة',
                hintStyle: TextStyle(color: Colors.white,fontSize: 13.0,fontWeight: FontWeight.w300),
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
                      itemBuilder: (context, index) => const SizedBox(),
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
  bool isPrim=true;

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
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('المرحلة التعليمية',style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: true,
              builder:(context)=> Wrap(
                children:[
                    levelChoose(context, 0),
                    levelChoose(context, 1),
                    levelChoose(context, 2),
                ],
              ),
              fallback: (context)=>Container(),
            ),
            const SizedBox(height: 10.0,),
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('المواد الدراسية',style: Theme.of(context).textTheme.titleMedium,),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: isPrim,
              builder:(context)=> prim(),
              fallback: (context)=>second(),
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

  Widget levelChoose(BuildContext context,int index)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),),
            label: Text(eduLevel[index]),
            labelStyle: const TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w300),
            selected: levelSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).cardColor,
            onSelected: (bool select){
              setState(() {
                for(int i=0;i<3;i++) {
                  if(i==index){
                    levelSelections[index] = !levelSelections[index];
                    continue;
                  }
                  levelSelections[i] = false;
                  itemChange(eduLevel[i], false);
                }
                if(levelSelections[0]){
                  isPrim=false;
                } else if(levelSelections[1]||levelSelections[2]){
                  isPrim=true;
                }
                itemChange(eduLevel[index], select);
              });
            }
        ),
      );
  Widget chooses(BuildContext context,int index)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),),
            label: Text(subjects[index]),
            labelStyle: const TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w300),
            selected: subSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).cardColor,
            onSelected: (bool select){
              setState(() {
                itemChange(subjects[index], select);
                subSelections[index] = !subSelections[index];
                for(int i=0;i<15;i++) {
                  if(subSelections[i]){
                    continue;
                  }
                  itemChange(subjects[i], false);
                }
              });
            }
        ),
      );
  Widget prim()=>Wrap(
      children: [
        chooses(context, 0),
        chooses(context, 1),
        chooses(context, 2),
        chooses(context, 3),
        chooses(context, 4),
  ]);
  Widget second()=>Wrap(
      children: [
        chooses(context, 0),
        chooses(context, 1),
        chooses(context, 2),
        chooses(context, 3),
        chooses(context, 4),
        chooses(context, 5),
        chooses(context, 6),
        chooses(context, 7),
        chooses(context, 8),
        chooses(context, 9),
        chooses(context,10),
        chooses(context,11),
        chooses(context,12),
        chooses(context,13),
        chooses(context,14),
      ]);
}