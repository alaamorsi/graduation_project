import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:graduation_project/shared/component/constant.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../../layout/student/student_cubit/student_cubit.dart';
import '../../../layout/student/student_cubit/student_states.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var cubit = StudentCubit.get(context);
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {},
        builder: (context, state){
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * .02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * .02),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.start,
                            onFieldSubmitted: (value){
                              cubit.searchText = searchController.text;
                              cubit.startSearchFunction(value);
                            },
                            validator: (value){
                              return null;
                            },
                            style: const TextStyle(color: Colors.black87, fontSize: 16.0),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "enter the search word",
              
                              hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color:Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * .01),
                          height: screenWidth * .11,
                          width: screenWidth * .11,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(9.0)),
                          ),
                          child: IconButton(
                            onPressed: () {
                              StudentCubit.get(context).showSearchFilter(context);
                            },
                            icon: Icon(Icons.filter_alt_rounded,
                                size: screenWidth * .07,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * .02),
                    if (cubit.startSearch)
                      Wrap(
                        children: [
                          searchBy(context, 0, theme,cubit),
                          searchBy(context, 1, theme,cubit),
                          searchBy(context, 2, theme,cubit),
                          searchBy(context, 3, theme,cubit),
                          IconButton(onPressed: (){
                            cubit.searchFunction(cubit.searchText, cubit.catSearchBy!);
                          }, icon: Icon(Icons.search,color: theme.primaryColor,)),
                        ],
                      ),
                    ConditionalBuilder(
                      condition: state is SearchSuccessState ||cubit.searchList.isNotEmpty,
                      builder: (context) => ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => courseItem(
                            context: context,
                            course: cubit.searchList[index],
                            color: theme.primaryColor,
                            addToWishList: () {
                              cubit.addToFavourite(cubit.searchList[index]);
                            }),
                        itemCount: cubit.searchList.length,
                      ),
                      fallback: (context) => cubit.startSearching
                          ? const Center(child: CircularProgressIndicator())
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget searchBy(BuildContext context, int index, theme,StudentCubit cubit) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * .005, vertical: screenWidth * .003),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * .03),
            ),
            label: Text(cubit.category[index].tr),
            labelStyle: font.copyWith(
              fontSize: 12.0,
              color: Colors.white,
            ),
            selected: cubit.categorySelections[index],
            backgroundColor: Colors.grey,
            selectedColor: theme.primaryColor,
            onSelected: (bool select) {
              cubit.changeTheSearchByFunction(index);
            }),
      );
}

class MultiSelect extends StatefulWidget {
  const MultiSelect({super.key});

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final levelSelections = [
    false,
    false,
    false,
  ];
  final subSelections = [
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
    false,
    false,
    false,
    false,
  ];
  final prices = [
    '<${'EGP'.tr}200',
    '${'EGP'.tr}200-${'EGP'.tr}500',
    '>${'EGP'.tr}500',
  ];
  final pricesSelection = [
    false,
    false,
    false,
  ];

  List<String> selectedItems = [];
  bool isPrim = true;
  bool isMidLevel = false;

  void itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void cansel() {
    Navigator.pop(context);
  }

  void submit() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AlertDialog.adaptive(
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Center(
          child: Text(
        'Search filter'.tr,
        style: font.copyWith(color: theme.primaryColorDark, fontSize: 16.0),
      )),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('Stage'.tr,
                style: font.copyWith(
                    color: theme.primaryColorDark, fontSize: 18.0)),
            const SizedBox(
              height: 10,
            ),
            ConditionalBuilder(
              condition: true,
              builder: (context) => Wrap(
                children: [
                  levelChoose(context, 0, theme),
                  levelChoose(context, 1, theme),
                  levelChoose(context, 2, theme),
                ],
              ),
              fallback: (context) => Container(),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text('Subjects'.tr,
                style: font.copyWith(
                    color: theme.primaryColorDark,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 10,
            ),
            ConditionalBuilder(
              condition: isPrim,
              builder: (context) => Wrap(children: [
                chooses(context, 0, theme),
                chooses(context, 1, theme),
                chooses(context, 2, theme),
                chooses(context, 3, theme),
                chooses(context, 4, theme),
              ]),
              fallback: (context) => ConditionalBuilder(
                condition: isMidLevel,
                builder: (context) {
                  return Wrap(children: [
                    chooses(context, 0, theme),
                    chooses(context, 1, theme),
                    chooses(context, 2, theme),
                    chooses(context, 3, theme),
                    chooses(context, 4, theme),
                    chooses(context, 5, theme),
                    chooses(context, 6, theme),
                    chooses(context, 7, theme),
                    chooses(context, 8, theme),
                    chooses(context, 9, theme),
                    chooses(context, 10, theme),
                    chooses(context, 11, theme),
                    chooses(context, 12, theme),
                  ]);
                },
                fallback: (context) {
                  return Wrap(children: [
                    chooses(context, 0, theme),
                    chooses(context, 1, theme),
                    chooses(context, 2, theme),
                    chooses(context, 3, theme),
                    chooses(context, 4, theme),
                    chooses(context, 5, theme),
                    chooses(context, 6, theme),
                    chooses(context, 7, theme),
                    chooses(context, 8, theme),
                    chooses(context, 9, theme),
                    chooses(context, 10, theme),
                    chooses(context, 11, theme),
                    chooses(context, 12, theme),
                    chooses(context, 13, theme),
                    chooses(context, 14, theme),
                    chooses(context, 15, theme),
                    chooses(context, 16, theme),
                    chooses(context, 17, theme),
                    chooses(context, 18, theme),
                  ]);
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text('Price'.tr,
                style: font.copyWith(
                    color: theme.primaryColorDark,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 10,
            ),
            ConditionalBuilder(
              condition: true,
              builder: (context) => Wrap(
                children: [
                  priceChoose(context, 0, theme),
                  priceChoose(context, 1, theme),
                  priceChoose(context, 2, theme),
                ],
              ),
              fallback: (context) => Container(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(theme.scaffoldBackgroundColor),
                  side: MaterialStatePropertyAll(
                      BorderSide(color: theme.primaryColor)),
                ),
                onPressed: cansel,
                child: Text(
                  'Clear'.tr,
                  style:
                      font.copyWith(color: theme.primaryColor, fontSize: 15.0),
                )),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(theme.primaryColor)),
                  onPressed: submit,
                  child: Text(
                    'Apply filter'.tr,
                    style: font.copyWith(color: Colors.white, fontSize: 16.0),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget levelChoose(BuildContext context, int index, theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            label: Text(stage[index].tr),
            labelStyle: font.copyWith(
              fontSize: 12.0,
              color: Colors.white,
            ),
            selected: levelSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: theme.primaryColor,
            onSelected: (bool select) {
              setState(() {
                for (int i = 0; i < 3; i++) {
                  if (i == index) {
                    levelSelections[index] = !levelSelections[index];
                    continue;
                  }
                  levelSelections[i] = false;
                  itemChange(stage[i], false);
                }
                if (levelSelections[0]) {
                  isPrim = true;
                  isMidLevel = false;
                } else if (levelSelections[1]) {
                  isMidLevel = true;
                  isPrim = false;
                } else {
                  isPrim = false;
                  isMidLevel = false;
                }
                itemChange(stage[index], select);
              });
            }),
      );

  Widget chooses(BuildContext context, int index, theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            label: Text(subjects[index].tr),
            labelStyle: font.copyWith(
              fontSize: 12.0,
              color: Colors.white,
            ),
            selected: subSelections[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (bool select) {
              setState(() {
                itemChange(subjects[index], select);
                subSelections[index] = !subSelections[index];
                for (int i = 0; i < 15; i++) {
                  if (subSelections[i]) {
                    continue;
                  }
                  itemChange(subjects[i], select);
                }
              });
            }),
      );

  Widget priceChoose(BuildContext context, int index, theme) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            label: Text(prices[index]),
            labelStyle: font.copyWith(
              fontSize: 12.0,
              color: Colors.white,
            ),
            selected: pricesSelection[index],
            backgroundColor: Colors.grey,
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (bool select) {
              setState(() {
                itemChange(prices[index], select);
                pricesSelection[index] = !pricesSelection[index];
                for (int i = 0; i < 3; i++) {
                  if (pricesSelection[i]) {
                    continue;
                  }
                  itemChange(prices[i], select);
                }
              });
            }),
      );
}
