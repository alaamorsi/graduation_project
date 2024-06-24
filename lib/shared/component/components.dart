import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/layout/student/student_cubit/student_cubit.dart';
import 'package:graduation_project/modules/student/course_demo/course_demo.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../models/courses_model.dart';
import 'constant.dart';
import 'package:file_picker/file_picker.dart';

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
  bool atEnd = true,
}) =>
    ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2.0,
          shadowColor: Colors.white,
          backgroundColor: color,
          padding: EdgeInsets.all(paddingSize),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
        child: Row(
          mainAxisAlignment:
              atEnd ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            isLoading
                ? loading
                : Text(
                    text,
                    style: font.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
          ],
        ));

//default input form field
Widget defaultFormField({
  required BuildContext context,
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
  int maxLines=1,
  double radius = 25.0,
  double width = 1.2,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      maxLines: maxLines,
      obscureText: isPassword,
      enabled: isClickable,
      cursorColor: Colors.black,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: const TextStyle(color: Colors.black87, fontSize: 16.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: label,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13.0),
        prefixIcon: thereSuffix ? Icon(suffixIcon) : null,
        suffixIcon: therePrefix
            ? IconButton(onPressed: prefixPressed, icon: Icon(prefixIcon))
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
            color:Theme.of(context).primaryColorDark,
            width: width,
          ),
        ),
      ),
    );

//default input form field
Widget editFormField({
  required BuildContext context,
  required TextEditingController controller,
  void Function(String)? onSubmit,
  Function(String val)? onChanged,
  required String? Function(String? val)? validate,
  required String? label,
}) =>
    TextFormField(
      autofocus: true,
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: Theme.of(context).primaryColor,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
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
}) =>
    DropdownMenu(
      width: screenWidth * 5 / 6,
      enableSearch: false,
      label: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      initialSelection: initialSelectionText,
      dropdownMenuEntries: chooses,
      onSelected: onSelect,
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
  bool hasActions = true,
  bool centerTitle = true,
}) =>
    AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 70.0,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 35),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Image(
          image: const AssetImage("Assets/appbar2.png"),
          color: Theme.of(context).primaryColor,
        ),
      ),
      centerTitle: centerTitle,
      title: Text(
        title,
        style: font.copyWith(
            fontSize: 25.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor),
      ),
      actions: hasActions ? actions : [],
    );

PreferredSizeWidget secondAppbar({
  required BuildContext context,
  required String title,
  Widget? actionIcon,
  bool hasAction = false,
  bool hasBeforeBack = false,
  void Function()? beforeBack,
}) =>
    AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      toolbarHeight: 70.0,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 35),
      titleTextStyle:
          font.copyWith(fontSize: 25.0, color: Theme.of(context).primaryColor),
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
          ),
          child: IconButton(
            onPressed: () {
              if(hasBeforeBack){
                beforeBack!();
              }else{}
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      title: Text(title),
      centerTitle: true,
      actions: hasAction
          ? [
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: actionIcon)
            ]
          : [],
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
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 15),
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
  required String title,
  required String description,
  required MotionState state,
  required BuildContext context,
}) =>
    MotionToast(
      icon: chooseToastIcon(state),
      primaryColor: chooseToastColor(state),
      title: Text(title),
      description: Text(description),
      width: 300,
      height: 100,
    ).show(context);

// enum
enum MotionState {
  success,
  error,
  warning,
  info,
  delete,
}

Color chooseToastColor(MotionState state) {
  Color color;
  switch (state) {
    case MotionState.success:
      color = Colors.greenAccent;
      break;
    case MotionState.error:
      color = Colors.redAccent;
      break;
    case MotionState.warning:
      color = Colors.amberAccent;
      break;
    case MotionState.info:
      color = Colors.blueAccent;
      break;
    case MotionState.delete:
      color = Colors.purpleAccent;
      break;
  }
  return color;
}

IconData chooseToastIcon(MotionState state) {
  IconData icon;
  switch (state) {
    case MotionState.success:
      icon = Icons.gpp_good;
      break;
    case MotionState.error:
      icon = Icons.gpp_bad;
      break;
    case MotionState.warning:
      icon = Icons.warning;
      break;
    case MotionState.info:
      icon = Icons.info;
      break;
    case MotionState.delete:
      icon = Icons.delete;
      break;
  }
  return icon;
}

Widget slideItem({
  required BuildContext context,
  required String title,
  required String image,
  required void Function()? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, vertical: screenWidth * 0.075),
      margin: EdgeInsets.all(screenWidth * 0.02),
      width: screenWidth * 0.9,
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.7),
        borderRadius:
            const BorderRadius.all(Radius.circular(23.0)), // color: cardColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
            width: screenWidth * .3,
          ),
          SizedBox(width: screenWidth * .1),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * .4,
                child: Text(
                  title,
                  style: font.copyWith(
                      fontSize: screenWidth * .066,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Discovery item
Widget courseItem({
  required BuildContext context,
  required CourseModel course,
  required Color color,
  bool isReserved = false,
  required void Function() addToWishList,
}) {
  ImageProvider<Object> image = iWillReturnImage(course.instProfilePicture);
  return InkWell(
    onTap: () {
      StudentCubit.get(context).getCourseDetails(course.courseId);
      navigateTo(
          context,
          CourseDemo(
            course: course,
          ));
    },
    child: Container(
      padding: EdgeInsets.all(screenWidth * 0.02),
      margin: EdgeInsets.all(screenWidth * 0.02),
      width: screenWidth,
      height: screenHeight * 0.14,
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(23.0),
        ),
      ),
      child: Row(
        children: [
          //Teacher image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: screenHeight / 10,
              height: screenHeight / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  course.subject.tr,
                  style: font.copyWith(fontSize: 16.0, color: color),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  '${course.lessonsNumber} ${'lessons'.tr}',
                  style: font.copyWith(
                      fontSize: 12.0, color: Colors.black.withOpacity(.5)),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Icons.star_rate_rounded,
                      size: 20.0,
                      color: HexColor("FDBD01"),
                    ),
                    Text(
                      '${course.rate}',
                      style: font.copyWith(
                          fontSize: 12.0, color: Colors.black.withOpacity(.5)),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: IconButton(
                    onPressed: addToWishList,
                    icon: course.favourite
                        ? Icon(
                            Icons.favorite,
                            color: color,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: color,
                          )),
              ),
              Expanded(
                child: Text(
                  '${'EGP'.tr}${course.price}',
                  style: font.copyWith(fontSize: 14.0, color: color),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget item(IconData icon, String text) {
  return Expanded(
    child: Row(
      children: [
        Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          text,
          style: font.copyWith(fontSize: 12.0, color: Colors.white),
          textAlign: TextAlign.end,
        ),
      ],
    ),
  );
}

//to show the rate as stars from 1 to 5
Widget rate({
  required double rate,
}) {
  bool s1, s2, s3, s4, s5 = false;
  if (rate < 5) {
    s1 = (rate % 5) >= 1;
    s2 = (rate % 5) >= 2;
    s3 = (rate % 5) >= 3;
    s4 = (rate % 5) >= 4;
  } else {
    s1 = s2 = s3 = s4 = s5 = true;
  }
  return Wrap(
    children: [
      Icon(
        Icons.star_rate_rounded,
        size: 20.0,
        color: s1 ? HexColor("FDBD01") : Colors.grey,
      ),
      Icon(
        Icons.star_rate_rounded,
        size: 20.0,
        color: s2 ? HexColor("FDBD01") : Colors.grey,
      ),
      Icon(
        Icons.star_rate_rounded,
        size: 20.0,
        color: s3 ? HexColor("FDBD01") : Colors.grey,
      ),
      Icon(
        Icons.star_rate_rounded,
        size: 20.0,
        color: s4 ? HexColor("FDBD01") : Colors.grey,
      ),
      Icon(
        Icons.star_rate_rounded,
        size: 20.0,
        color: s5 ? HexColor("FDBD01") : Colors.grey,
      ),
    ],
  );
}

Widget themeItem({
  required String title,
  required Color cardColor,
  required IconData icon,
  required void Function() tap,
}) {
  return InkWell(
    onTap: tap,
    child: Container(
      margin:  EdgeInsets.all(screenWidth*.03),
      padding: EdgeInsets.all(screenWidth*.03),
      height: screenWidth * .42,
      width: screenWidth * .41,
      decoration: BoxDecoration(
        color: cardColor.withOpacity(.3),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 54, color: cardColor),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: font.copyWith(
              fontSize: 18.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget dashboardItem({
  required BuildContext context,
  required String title,
  required String image,
  required void Function() goTo,
}) {
  return InkWell(
    onTap: goTo,
    child: Container(
      margin: EdgeInsets.all(screenWidth * .03),
      height: screenHeight * .27,
      width: screenWidth * .41,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).cardColor,
                blurRadius: .9,
                spreadRadius: .6),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).cardColor,
              child: Center(
                child: CircleAvatar(
                  radius: 39,
                  child: Image(
                    image: AssetImage(image),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight*0.01),
            child: Text(
              title,
              style: font.copyWith(
                  fontSize: screenWidth*0.06, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    ),
  );
}

ImageProvider<Object> iWillReturnImage(String? pictureUrl){
  ImageProvider<Object> image = const AssetImage("Assets/profile/man_1.png");
  if (pictureUrl!.isNotEmpty) {
    Uint8List picture = base64Decode(pictureUrl);
    image = MemoryImage(picture);
  }
  return image;
}

Widget selectedFile(PlatformFile? file){
  if(file != null){
    final kb = file.size /1024;
    final mb = kb / 1024;
    final fileSize = mb>=1? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    final extension = file.extension ?? 'none';
    final color = getColor(extension);
    return SizedBox(
      height: screenWidth * .4,
      width: screenWidth * .4,
      child: Stack(
          alignment: isArabic?Alignment.topLeft:Alignment.topRight,
          children:[
          const Icon(Icons.clear_outlined,color: Colors.black,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    '.$extension',
                    style: font.copyWith(fontSize: 28,color:Colors.white),
                  ),
                ),
              ),
              const SizedBox(height:10),
              Text(
                file.name,
                style:font.copyWith(fontSize: 18,fontWeight: FontWeight.bold),
                overflow:TextOverflow.ellipsis,
              ),
              Text(
                fileSize,
                style:font.copyWith(fontSize: 16),
              ),
            ],
          ),
        ]
      )
    );
  } else{
    return const SizedBox();
  }

}
Color getColor(String extension){
  if(extension == 'pdf'){
    return Colors.red.shade600;
  }if(extension == 'doc'){
    return Colors.green.shade600;
  } else{
    return Colors.grey.shade600;
  }
}
String changeNumTo2Digits(int num){
  if(num < 10){
    return "0""$num";
  }
  else{
    return num.toString();
  }
}
