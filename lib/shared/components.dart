import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/modules/settings.dart';

import 'constant.dart';
/////////////////////////////////////////////////////

Widget usedButton({
  void Function()? onPressed,
  required String text,
  required Color color,
  required BuildContext context,
  double paddingSize = 15.0,
  double radius = 25.0,
  bool atEnd=true,
}) =>ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 2.0,
      shadowColor: Colors.white,
      backgroundColor: color,
      padding: EdgeInsets.all(paddingSize),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    ),
    child: Row(
      mainAxisAlignment: atEnd?MainAxisAlignment.end:MainAxisAlignment.center,
      children: [
        Text(
          text,
          style:TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),
        ),
      ],
    ));

//default input form field
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  Function(String val)? onChanged,
  bool isPassword = false,
  required String? Function(String? val)? validate,
  required String label,
  required IconData suffixIcon,
  IconData? prefixIcon,
  void Function()? prefixPressed,
  bool isClickable = true,
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      cursorColor: Colors.black,
      textAlign: TextAlign.end,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: const TextStyle(color: Colors.blue,fontSize: 16.0),
      decoration:InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: TextStyle(color: Colors.black26, fontSize: 13.0),
        suffixIcon:Icon(suffixIcon),
        prefixIcon:IconButton(onPressed: prefixPressed, icon: Icon(prefixIcon)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0
          ),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black87,
            width: 1.2,
          ),
        ),

        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black87,
            width: 1.2,
          ),
        ),
      ),
    );

///////////////
Widget myDropDownMenu({
  required BuildContext context,
  required String textLabel,
  required String initialSelectionText,
  required List<DropdownMenuEntry> chooses,
  required void Function(dynamic) onSelect,
  Color lightColor = Colors.white,
  Color darkColor = Colors.black,
  double radius = 25.0,
})
=> DropdownMenu(
  width: 300.0,
  enableSearch: false,
  label: Text(textLabel,style: Theme.of(context).textTheme.titleMedium,),
  initialSelection: initialSelectionText,
  dropdownMenuEntries: chooses,
  onSelected: onSelect,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: Theme.of(context).textTheme.titleSmall,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
          color: mode?darkColor:lightColor,
          width: 2.0
      ),
    ),
    enabledBorder:OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: mode?darkColor:lightColor,
        width: 2.0,
      ),
    ),
  ),
  textStyle: Theme.of(context).textTheme.titleSmall,
  menuStyle: MenuStyle(
    backgroundColor: MaterialStateProperty.all(mode?lightColor:darkColor),
    side: MaterialStateProperty.all(
      BorderSide(color: mode?darkColor:lightColor,),
    ),
  ),
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String logo,
}) => AppBar(
  iconTheme: Theme.of(context).appBarTheme.iconTheme,
  titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
  leading: Padding(
  padding: const EdgeInsets.only(left: 10.0),
  child: IconButton(onPressed: (){}, icon: Icon(Icons.search)),
  ),
  title: Image(image: AssetImage(logo)),
  actions: [
  Padding(
  padding: const EdgeInsets.only(right: 10.0),
  child: IconButton(onPressed: (){navigateTo(context, SettingsScreen());}, icon: Icon(Icons.settings)),
  )
  ],
  elevation: 2.0,
  );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 10.0,
        color: Colors.white,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> rout) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
// Discovery item
Widget buildDiscoveryItem(BuildContext context, index)
{
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: EdgeInsetsDirectional.only(start: 5.0,top: 5.0,end: 5.0),
    child: InkWell(
      onTap: (){},
      child: Container(
        width: screenWidth,
        // height: screenHeight /4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  width: screenWidth / 2.5,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      image: DecorationImage(
                          image: AssetImage('Assets/splash_logo.png'),
                          fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Text(
                          'علاء مرسي فتحي',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        )),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Text(
                                      'الثالث الثانوي',
                                      style: TextStyle(fontSize: 10.0),
                                      textAlign: TextAlign.end,
                                    )),
                                SizedBox(width: 5.0),
                                Icon(
                                  Icons.school,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Text(
                                      'انجليزي',
                                      style: TextStyle(fontSize: 10.0),
                                      textAlign: TextAlign.end,
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.book,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      '2024',
                                      style: TextStyle(fontSize: 10.0),
                                      textAlign: TextAlign.end,
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.hourglass_bottom,
                                  size: 20.0,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Text(
                                      'ترم اول',
                                      style: TextStyle(fontSize: 10.0),
                                      textAlign: TextAlign.end,
                                    )),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.layers_sharp,
                                  size: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '128',
                            style: TextStyle(fontSize: 10.0),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.play_circle,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );}

