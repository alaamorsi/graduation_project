import 'package:flutter/material.dart';
import 'package:graduation_project/modules/registeration/login/login_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import '../../shared/component/constant.dart';

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
            Text("Choose freely.",style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "Choose from hundreds of teachers, online and recorded lessons.",
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    navigateAndFinish(context, const LoginScreen());
                  },
                  child: Text("SKIP",style: font.copyWith(color: Colors.white,fontSize: 14.0),),
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
            Text("Easy to learn.",style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "Enjoy watching a free introduction of all content before buying, rate and ask in each lesson separately.",
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 60,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    navigateAndFinish(context, const LoginScreen());
                  },
                  child: Text("SKIP",style: font.copyWith(color: Colors.white,fontSize: 14.0),),
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
            Text("Level up.",style: font.copyWith(color: Colors.white,fontSize: 30.0),),
            const SizedBox(height: 10,),
            Text(
              "Solve the task assigned in each lesson to test your level.",
              style: font.copyWith(color: Colors.white,fontSize: 14.0),
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left:150.0,),
              child: InkWell(
                onTap: (){
                  navigateAndFinish(context, const LoginScreen());
                },
                child: Container(
                  height:45,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [BoxShadow(color: Colors.white,offset: Offset(-2, 4),spreadRadius: 2)]
                  ),
                  child:Text("Get started",style: font.copyWith(color: Colors.greenAccent,fontSize: 16.0),),
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
                selectedColor: Colors.red,
                borderStyle: BorderStyle.none,
              ),
          )
        ],
      ),
    );
  }
}
