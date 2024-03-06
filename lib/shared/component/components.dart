import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/modules/student/paid_course/class_material.dart';
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
      mainAxisAlignment: atEnd?MainAxisAlignment.start:MainAxisAlignment.center,
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
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: const TextStyle(color: Colors.black87,fontSize: 16.0),
      decoration:InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.0),
        prefixIcon:thereSuffix?Icon(suffixIcon):null,
        suffixIcon:therePrefix?IconButton(onPressed: prefixPressed, icon: Icon(prefixIcon)):null,
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
  IconData? leadingIcon,
  void Function()? leadingFunction,
  required Widget title,
  IconData? atEndIcon,
  void Function()? atEndFunction,
  bool atEnd = true,
  bool hasLeading = false,
  bool titleInCenter = false,
}) =>
    AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 70.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(11.0),
          bottomRight: Radius.circular(11.0),
        ),
      ),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
      titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
      leading: hasLeading? Padding(padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(onPressed: leadingFunction, icon: Icon(leadingIcon))):null,
      title: title,
      centerTitle: titleInCenter,
      actions: atEnd?[Padding(padding: const EdgeInsets.only(right: 10.0),
          child: IconButton(
              onPressed: atEndFunction,
              icon: Icon(atEndIcon),
          ),
        ),]:[],
  );

PreferredSizeWidget secondAppbar({
  required BuildContext context,
  required String title,
  Widget? actionIcon,
  bool hasAction=false,
}) =>
    AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 70.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(11.0),
          bottomRight: Radius.circular(11.0),
        ),
      ),
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor,size: 35),
      titleTextStyle:font.copyWith(fontSize: 25.0,color: Theme.of(context).primaryColor),
      leading:Padding(
        padding: const EdgeInsets.only(
            left: 14.0,top: 14.0,bottom: 14.0
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 7.0),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
          ),
          child: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios,size: 20,color: Theme.of(context).primaryColor,),
          ),
        ),
      ),
      title: Text(title),
      actions: hasAction?[Padding(padding: const EdgeInsets.only(right: 10.0),
        child: actionIcon)]:[],
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

Widget newDivider() => Padding(
  padding: const EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 15),
  child: Container(
    width: double.infinity,
    height: 0.3,
    color: Colors.grey,
  ),
);

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
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
  bool isReserved =false,
}) {
  // bool hover = false;
  return Padding(
    padding: const EdgeInsetsDirectional.all(10.0),
    child: InkWell(
      onTap: (){navigateTo(context, const ClassMaterial());},
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

// Discovery item
Widget discoveryItem({
  required BuildContext context,
  required String courseTeacherName,
  required String courseTeacherImage,
  required String courseSubject,
  required String courseEduLevel,
  required int courseTerm,
  required int courseYear,
  required int courseVideosNumber,
  required Color cardColor,
  bool isReserved =false,
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.all(10.0),
    child: InkWell(
      onTap:(){navigateTo(context, const ClassMaterial());},
      child: Container(
        width: screenWidth,
        height: screenHeight/4+50,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(23.0)),
          color: cardColor,
        ),
        child:Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      //teacher name
                      Expanded(
                        child: Text(
                          courseTeacherName,
                          style: font.copyWith(
                              fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.white),
                          overflow: TextOverflow.ellipsis,),
                      ),
                      item(Icons.school, courseEduLevel),
                      item(Icons.book, courseSubject),
                      item(Icons.hourglass_bottom, '$courseYear'),
                      item(Icons.layers_sharp, '$courseTerm term'),
                      item(Icons.video_collection, '$courseVideosNumber video'),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        height:110,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: NetworkImage(courseTeacherImage),
                              fit: BoxFit.cover),
                          ),
                        ),
                      const SizedBox(height: 15,),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          color: Colors.orange,
                        ), child: const Text("Check Now")
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                const Icon(Icons.sell,color: Colors.orange,size: 66.0,),
                Text("200 EP",style: font.copyWith(fontSize: 12.0,color: Theme.of(context).primaryColorLight,),)
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget item(IconData icon,String text){
  return Expanded(
    child: Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
        const SizedBox(width: 5.0,),
        Text(
          text,
          style: font.copyWith(fontSize: 12.0,color: Colors.white),
          textAlign: TextAlign.end,
        ),
      ],
    ),
  );
}


