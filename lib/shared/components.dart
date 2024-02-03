// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/////////////////////////////////////////////////////
//default text form field
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  Function(String val)? onChanged,
  bool isPassword = false,
  required String? Function(String? val)? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        cursorColor: Colors.black,
        textAlign: TextAlign.end,
        onFieldSubmitted: onSubmit,
        onChanged: onChanged,
        validator: validate,
        style: TextStyle(color: Colors.black,fontSize: 22),
        decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 25,),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.grey,
              size: 40,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(
                      suffixIcon,
                    ),
                  )
                : null,
            border: InputBorder.none),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
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

