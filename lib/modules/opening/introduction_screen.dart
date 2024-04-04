import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/opening/make_your_settings.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import '../../shared/component/constant.dart';
import '../registration/login/login_screen.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> with SingleTickerProviderStateMixin {
  late final TabController controller;
  int index=0;
  
  @override
  void initState() {
    super.initState();
    controller = TabController(
        length: 3,
        initialIndex: index,
        vsync: this,
    );
    CacheHelper.putBoolean(key: 'firstInstall', value: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages=[
      Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.indigoAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: const AssetImage("Assets/intro/intro1.png"),
              fit: BoxFit.cover,
              height: screenHeight/2.5,
              width: screenWidth,
            ),
            const SizedBox(height: 30,),
            Text("Save time".tr,style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "save your time in searching for a good teacher".tr,
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Get.offAll(const MakeYourSettingScreen());
                  },
                  child: Text("SKIP".tr,style: font.copyWith(color: Colors.white,fontSize: 14.0),),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    controller.index=1;
                  });
                }, child: const Icon(Icons.arrow_forward,color:Colors.indigoAccent,size:30))
              ],
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.orangeAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: const AssetImage("Assets/intro/intro2.png"),
              fit: BoxFit.cover,
              height: screenHeight/2.5,
              width: screenWidth,
            ),
            const SizedBox(height: 30,),
            Text("Easy to learn".tr,style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "Enjoy a free introduction".tr,
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Get.offAll(const MakeYourSettingScreen());
                  },
                  child: Text("SKIP".tr,style: font.copyWith(color: Colors.white,fontSize: 14.0),),
                ),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        controller.index = 2;
                      });
                    },
                    child: const Icon(Icons.arrow_forward,color:Colors.orangeAccent,size:30))
              ],
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
          color: Colors.greenAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image(
              image: const AssetImage("Assets/intro/intro3.png"),
              fit: BoxFit.cover,
              height: screenHeight/2.5,
              width: screenWidth,
            ),
            const SizedBox(height: 30,),
            Text("Level up".tr,style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "Solve the assigned".tr,
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:150.0,),
              child: InkWell(
                onTap: (){
                  Get.off(const MakeYourSettingScreen());
                },
                child: Container(
                  height:45,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [BoxShadow(color: Colors.white,offset: Offset(-2, 4),spreadRadius: 2)]
                  ),
                  child:Text("Get started".tr,style: font.copyWith(color: Colors.greenAccent,fontSize: 16.0),),
                ),
              ),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          TabBarView(
            controller: controller,
            children: pages,
          ),
          Positioned(
              bottom: 30,
              child: TabPageSelector(
                controller: controller,
                color: Colors.white,
                selectedColor: Colors.red.shade900,
                borderStyle: BorderStyle.none,
              ),
          )
        ],
      ),
    );
  }
}
