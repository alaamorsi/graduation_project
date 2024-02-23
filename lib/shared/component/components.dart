import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/student/course_demo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'constant.dart';
/////////////////////////////////////////////////////


Widget usedButton({
  void Function()? onPressed,
  Widget loading = const CircularProgressIndicator(),
  bool isLoading = false,
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
      children:[
        isLoading? loading: Text(
          text,
          style: GoogleFonts.changa().copyWith(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),
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
  IconData? suffixIcon,
  IconData? prefixIcon,
  void Function()? prefixPressed,
  bool thereSuffix = true,
  bool therePrefix = true,
  bool isClickable = true,
  double radius = 25.0,
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
      style: TextStyle(color: HexColor("#000080"),fontSize: 16.0),
      decoration:InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.black26, fontSize: 13.0),
        suffixIcon:thereSuffix?Icon(suffixIcon):null,
        prefixIcon:therePrefix?IconButton(onPressed: prefixPressed, icon: Icon(prefixIcon)):null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
              color: HexColor("#000080"),
              width: 2.0
          ),
        ),
        enabledBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.black87,
            width: 1.2,
          ),
        ),
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(
            color: Colors.black87,
            width: 1.2,
          ),
        ),
      ),
    );

///////////////
Widget myDropDownMenu({
  required BuildContext context,
  required String title,
  required String initialSelectionText,
  required List<DropdownMenuEntry> chooses,
  required void Function(dynamic) onSelect,
  double radius = 25.0,
})
=> DropdownMenu(
  width: screenWidth*5/6,
  enableSearch: false,
  label: Text(title,style: Theme.of(context).textTheme.titleMedium,),
  initialSelection: initialSelectionText,
  dropdownMenuEntries: chooses,
  onSelected: onSelect,
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required IconData leadingIcon,
  required void Function() leadingFunction,
  required Widget title,
  IconData? atEndIcon,
  void Function()? atEndFunction,
  bool atEnd = true,
}) =>
    AppBar(
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
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      leading: Padding(padding: const EdgeInsets.only(left: 10.0),
        child: IconButton(onPressed: leadingFunction, icon: Icon(leadingIcon)),
      ),
      title: title,
      actions: atEnd?[Padding(padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
              onPressed: atEndFunction,
              icon: Icon(atEndIcon),
          ),
        ),]:[],
  );



Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 10.0,
        bottom: 10.0,
      ),
      child: Container(
        width: double.infinity,
        height: 3.0,
        color: HexColor("#666666"),
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

/////////////////////

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
enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

// Discovery item
Widget buildDiscoveryItem({
  required BuildContext context,
  required String courseTeacherName,
  required String courseTeacherImage,
  required String courseSubject,
  required String courseEduLevel,
  required int courseTerm,
  required int courseYear,
  required int courseVideosNumber,
  required Color cardColor,
}) {
  // bool hover = false;
  return Padding(
    padding: const EdgeInsetsDirectional.all(10.0),
    child: InkWell(
      onTap: (){
        navigateTo(context, const CourseDemo());
      },
      child: AnimatedContainer(
        width: screenWidth *5/6,
        height: screenHeight/3,
        color:Colors.grey.withOpacity(0.0),
        duration: const Duration(seconds: 1),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            //for the gray backLayer
            Padding(
              padding: const EdgeInsets.only(top: 20.0,right: 10.0),
              child: Container(
                width: screenWidth *4/5,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(21.0)),
                  color: cardColor,
                ),
              ),
            ),
            //for the first one
            Padding(
              padding: const EdgeInsets.only(left: 20.0,bottom: 20.0),
              child: Container(
                width: screenWidth *4/5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(21.0)),
                  image: DecorationImage(
                      image: AssetImage("Assets/cardBack1.png"),
                      fit: BoxFit.fill
                  ),
                  // color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0,),
                  child: Row(
                    children: [
                      //teacher Image
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 81.0,
                            height: 81.0,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35.0),
                                  bottomRight: Radius.circular(35.0),
                                  topRight: Radius.circular(3.0),
                                  bottomLeft: Radius.circular(3.0),
                                ),
                                color: Colors.white
                            ),
                            child: Center(
                              child: Container(
                                width: 79.0,
                                height: 79.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(35.0),
                                    bottomRight: Radius.circular(35.0),
                                    topRight: Radius.circular(3.0),
                                    bottomLeft: Radius.circular(3.0),
                                  ),
                                  image: DecorationImage(
                                    image:  NetworkImage(courseTeacherImage),
                                    fit: BoxFit.fill,),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                      const SizedBox(width: 5.0,),
                      //teacher and course data
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //teacher name
                            Expanded(
                              child: Text(
                                courseTeacherName,
                                style: font.copyWith(
                                    fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
                                overflow: TextOverflow.ellipsis,),),
                            const SizedBox(height: 10.0,),
                            //subject and eduLevel
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
                                              courseEduLevel,
                                              style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                              textAlign: TextAlign.end,
                                            )),
                                        const SizedBox(width: 5.0),
                                        const Icon(
                                          Icons.school,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              courseSubject,
                                              style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                              textAlign: TextAlign.end,
                                            )),
                                        const SizedBox(width: 5.0,),
                                        const Icon(
                                          Icons.book,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //term and year of course
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
                                              '$courseYear',
                                              style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                              textAlign: TextAlign.end,
                                            )),
                                        const SizedBox(width: 5.0,),
                                        const Icon(
                                          Icons.hourglass_bottom,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5.0,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                            child: Text(
                                              '$courseTerm',
                                              style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                              textAlign: TextAlign.end,
                                            )),
                                        const SizedBox(width: 5.0,),
                                        const Icon(
                                          Icons.layers_sharp,
                                          size: 20.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //number of videos
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$courseVideosNumber',
                                    style: font.copyWith(fontSize: 12.0,color: Colors.white),
                                  ),
                                  const SizedBox(width: 5.0,),
                                  const Icon(
                                    Icons.play_circle,
                                    size: 20.0,
                                    color: Colors.white,
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
          ],
        ),
      ),
    ),
  );}


