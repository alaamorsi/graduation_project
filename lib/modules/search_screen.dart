import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/layout/student/cubit/cubit.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = StudentCubit.get(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ConditionalBuilder(
                condition: false,
                builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => const SizedBox(),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: 4,
                ),
                fallback: (context) =>cubit.startSearching?const Center(child: CircularProgressIndicator()):Container(),
              ),
            ],
          ),
        ),
      ),
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
    'Arabic',
    'English',
    'Mathematics',
    'Studies',
    'Science',
    'French',
    'Italian',
    'German',
    'History',
    'geography',
    'Chemistry',
    'Physics',
    'Biology',
    'Psychology',
    'Philosophy'
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
    var theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Text('Search filter',style: font.copyWith(color: theme.primaryColorDark,fontSize: 16.0,fontWeight: FontWeight.w600),),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Education level',style: font.copyWith(color: theme.primaryColorDark,fontSize: 16.0,fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: true,
              builder:(context)=> Wrap(
                children:[
                    levelChoose(context, 0,theme),
                    levelChoose(context, 1,theme),
                    levelChoose(context, 2,theme),
                ],
              ),
              fallback: (context)=>Container(),
            ),
            const SizedBox(height: 10.0,),
            Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Subjects',style: font.copyWith(color: theme.primaryColorDark,fontSize: 16.0,fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: isPrim,
              builder:(context)=> Wrap(
                  children: [
                    chooses(context, 0,theme),
                    chooses(context, 1,theme),
                    chooses(context, 2,theme),
                    chooses(context, 3,theme),
                    chooses(context, 4,theme),
                  ]),
              fallback: (context)=>Wrap(
                  children: [
                    chooses(context, 0,theme),
                    chooses(context, 1,theme),
                    chooses(context, 2,theme),
                    chooses(context, 3,theme),
                    chooses(context, 4,theme),
                    chooses(context, 5,theme),
                    chooses(context, 6,theme),
                    chooses(context, 7,theme),
                    chooses(context, 8,theme),
                    chooses(context, 9,theme),
                    chooses(context, 10,theme),
                    chooses(context, 11,theme),
                    chooses(context, 12,theme),
                    chooses(context, 13,theme),
                    chooses(context, 14,theme),
                  ]),
            ),
            const SizedBox(height: 10.0,),
          ]
        ),
      ),
      actions: [Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style:  ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(theme.primaryColorLight)
              ),
              onPressed: cansel,
              child: Text('Clear',style: font.copyWith(color: theme.primaryColor,fontSize: 16.0,fontWeight: FontWeight.w600),)
            ),
            ElevatedButton(
              style:  ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(theme.primaryColor)
              ),
              onPressed: submit,
              child: Text('Apply filter',style: font.copyWith(color: theme.primaryColorLight,fontSize: 17.0,fontWeight: FontWeight.w600),)
            ),
          ],
        ),],
    );
  }

  Widget levelChoose(BuildContext context,int index,theme)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),),
            side: BorderSide(color: theme.primaryColor),
            label: Text(eduLevel[index]),
            labelStyle: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300),
            selected: levelSelections[index],
            backgroundColor: Colors.transparent,
            selectedColor: Theme.of(context).primaryColor,
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
  Widget chooses(BuildContext context,int index,theme)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),),
            side: BorderSide(color: theme.primaryColor),
            label: Text(subjects[index]),
            labelStyle: font.copyWith(color: theme.primaryColor,fontSize: 14.0,fontWeight: FontWeight.w300),
            selected: subSelections[index],
            backgroundColor: Colors.transparent,
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
}