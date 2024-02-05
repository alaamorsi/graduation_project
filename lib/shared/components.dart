// ignore_for_file: prefer_const_constructors
import 'dart:ui';

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
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
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
        style: TextStyle(color: Colors.black,),
        decoration:InputDecoration(
          filled: true,
          fillColor: Colors.white,

          hintText: label,
              hintStyle: TextStyle(color: Colors.black12, fontSize: 20,),
              // prefixIcon: Icon(
              //   prefixIcon,
              //   color: Colors.grey,
              // ),
            prefixIcon: prefixIcon != null
                  ? IconButton(
                      onPressed: suffixPressed,
                      icon: Icon(
                        prefixIcon,
                      ),
                    )
                  : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: Colors.green,
                width: 1.5
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),

        // InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2.0),
        //       borderSide: BorderSide(
        //         color: Colors.blue,
        //         width: 1,
        //       ),
        //     ),
        //     enabledBorder:OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(5.0),
        //       borderSide: BorderSide(
        //         color: Colors.blue,
        //         width: 1,
        //       ),
        //     ),
        //     hintText: label,
        //     hintStyle: TextStyle(color: Colors.black12, fontSize: 20,),
        //     // prefixIcon: Icon(
        //     //   prefixIcon,
        //     //   color: Colors.grey,
        //     // ),
        //   prefixIcon: prefixIcon != null
        //         ? IconButton(
        //             onPressed: suffixPressed,
        //             icon: Icon(
        //               prefixIcon,
        //             ),
        //           )
        //         : null,
        //   ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
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

