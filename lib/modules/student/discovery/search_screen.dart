import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';



class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var cubit = StudentCubit.get(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                SearchBar(
                  backgroundColor: MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
                  controller: searchController,
                  onChanged: (value){},
                  onSubmitted: (value) {},
                  trailing: [Padding(padding: const EdgeInsets.only(right: 13.0),
                    child:Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: IconButton(
                        onPressed: (){StudentCubit.get(context).showSearchFilter(context);},
                        icon: Icon(Icons.filter_alt_rounded,size: 25,color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )],
                ),
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
//backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         toolbarHeight: 70.0,
//         iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
//         titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
//         title: TextField(
//           controller: searchController,
//           textAlign: TextAlign.start,
//           decoration:  InputDecoration(
//             labelStyle: font.copyWith(fontSize: 14.0,color: theme.primaryColorDark),
//             hintText: 'enter teacher name or subject',
//             hintStyle: const TextStyle(color: Colors.grey,fontSize: 13.0,fontWeight: FontWeight.w300),
//             enabledBorder:const OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//                 borderSide: BorderSide(color: Colors.grey)
//             ),
//             focusedBorder:OutlineInputBorder(
//                 borderRadius: const BorderRadius.all(Radius.circular(30)),
//                 borderSide: BorderSide(color: theme.primaryColor)
//             ),
//           ),
//           keyboardType: TextInputType.text,
//           onChanged: (value){},
//           onSubmitted: (value) {},
//         ),
//         actions:[
//           Padding(padding: const EdgeInsets.only(right: 13.0),
//             child:Container(
//               height: 40,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.3),
//                 borderRadius: const BorderRadius.all(Radius.circular(9.0)),
//               ),
//               child: IconButton(
//                 onPressed: (){StudentCubit.get(context).showSearchFilter(context);},
//                 icon: Icon(Icons.filter_alt_rounded,size: 25,color: Theme.of(context).primaryColor),
//               ),
//             ),
//           ),
//         ],
class MultiSelect extends StatefulWidget {
  const MultiSelect({super.key});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}
class _MultiSelectState extends State<MultiSelect> {
  final eduLevel=[
    'High School',
    'Middle',
    'Primary',
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
  final prices=[
    '<EP200',
    'EP200-EP500',
    '>EP500',
  ];
  final pricesSelection=[
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
    return AlertDialog.adaptive(
      backgroundColor: theme.scaffoldBackgroundColor,
      title:Center(child: Text('Search filter',style: font.copyWith(color: theme.primaryColorDark,fontSize: 16.0),)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Text('Education level',style: font.copyWith(color: theme.primaryColorDark,fontSize: 18.0)),
            const SizedBox(height: 10,),
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
            Text('Subjects',style: font.copyWith(color: theme.primaryColorDark,fontSize: 17.0,fontWeight: FontWeight.w500)),
            const SizedBox(height: 10,),
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
            Text('Price',style: font.copyWith(color: theme.primaryColorDark,fontSize: 17.0,fontWeight: FontWeight.w500)),
            const SizedBox(height: 10,),
            ConditionalBuilder(
              condition: true,
              builder:(context)=> Wrap(
                children:[
                  priceChoose(context, 0,theme),
                  priceChoose(context, 1,theme),
                  priceChoose(context, 2,theme),
                ],
              ),
              fallback: (context)=>Container(),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
                style:  ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
                  side:  MaterialStatePropertyAll(BorderSide(color: theme.primaryColor)),
                ),
                onPressed: cansel,
                child: Text('Clear',style: font.copyWith(color: theme.primaryColor,fontSize: 15.0),)
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: ElevatedButton(
                  style:  ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(theme.primaryColor)
                  ),
                  onPressed: submit,
                  child: Text('Apply filter',style: font.copyWith(color: Colors.white,fontSize: 16.0),)
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget levelChoose(BuildContext context,int index,theme)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),),
            label: Text(eduLevel[index]),
            labelStyle: font.copyWith(fontSize: 12.0, color: Colors.white,),
            selected: levelSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: theme.primaryColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),),
            label: Text(subjects[index]),
            labelStyle: font.copyWith(fontSize: 12.0, color: Colors.white,),
            selected: subSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).primaryColor,
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

  Widget priceChoose(BuildContext context,int index,theme)=>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),),
            label: Text(prices[index]),
            labelStyle: font.copyWith(fontSize: 12.0, color: Colors.white,),
            selected: pricesSelection[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (bool select){
              setState(() {
                itemChange(prices[index], select);
                pricesSelection[index] = !pricesSelection[index];
                for(int i=0;i<15;i++) {
                  if(pricesSelection[i]){
                    continue;
                  }
                  itemChange(prices[i], false);
                }
              });
            }
        ),
      );
}