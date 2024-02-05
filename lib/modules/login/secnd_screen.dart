import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/student.login.dart';
import 'package:graduation_project/modules/login/teatsher_login.dart';

class secend_screen extends StatefulWidget {
  const secend_screen({Key? key}) : super(key: key);

  @override
  _secend_screenState createState() => _secend_screenState();
}

class _secend_screenState extends State<secend_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black ,
     appBar: AppBar(

       centerTitle: true,
       backgroundColor: Colors.black,
       title: RichText(
             text: TextSpan(


                 text: 'Educa',
                 style: TextStyle(
                   fontSize: 50.0,
                   color: Colors.blue,
                 ),
                 children: <TextSpan>[
                   TextSpan(
                       text: 'tiona',
                       style: TextStyle(
                         fontSize: 50.0,
                         color: Colors.yellow,
                       )),
                 ])),
     ),
     body:Column(
       children: [
         SizedBox(
           height: 30.0,
         ),

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: [
               Text(
                 'انشاء حساب',
                 style: TextStyle(
                   fontSize: 20.0,
                   color: Colors.white,
                 ),
               ),
             ],
           ),
         ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,

                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>teacherScreen(),));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(
                          'مدرس',
                          style:
                          TextStyle(
                              fontSize: 20.0,
                            color: Colors.white,




                          ),

                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,

                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>studenScreen(),));

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Text(
                          'طالب',
                          style:
                          TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,




                          ),

                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),

       ],
     ),
    );
  }}