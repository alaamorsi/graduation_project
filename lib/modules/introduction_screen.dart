import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/component/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../shared/component/constant.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {

  @override
  Widget build(BuildContext context) {
    final introKey = GlobalKey<IntroductionScreenState>();

    void onIntroEnd(context) {
      navigateAndFinish(context, const LoginScreen());
    }

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: MaterialButton(
            color: HexColor("#000080"),
            child: Text(
              "Let's go right away!",
              style: font.copyWith(fontSize: 16.0,color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () => onIntroEnd(context),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          titleWidget: Text("اختر بحرية",style: font.copyWith(color: Colors.black,fontSize: 22.0),),
          bodyWidget: Text(
            "اختر من بين مئات المدرسين والدروس الاونلاين والمسجلة",
            style: font.copyWith(color: Colors.black,fontSize: 18.0),
          ),
          image: Image.asset("Assets/intro1.png",height: 270.0),),
        PageViewModel(
          titleWidget: Text("تعليم سهل ومسلي",style: font.copyWith(color: Colors.black,fontSize: 22.0),),
          bodyWidget: Text(
            "استمتع بمشاهدة مقدمة مجانية من كل المحتويات قبل الشراء , قيم واسأل فى كل درساً على حدا",
            style: font.copyWith(color: Colors.black,fontSize: 18.0),
          ),
          image: Image.asset("Assets/intro2.png",height: 270.0),),
        PageViewModel(
          titleWidget: Text("ارتقي بمستواك",style: font.copyWith(color: Colors.black,fontSize: 22.0),),
          bodyWidget: Text(
            "قم بحل المهمة المنزلة على كل درس لإختبار مستواك",
            style: font.copyWith(color: Colors.black,fontSize: 18.0),
          ),
          image: Image.asset("Assets/intro3.png",height: 270.0),),
      ],
      onDone: () => onIntroEnd(context),
      onSkip: () => onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back,color: Colors.white,),
      skip: Text('Skip', style: font.copyWith(fontWeight: FontWeight.w600,color: Colors.white)),
      next: const Icon(Icons.arrow_forward,color: Colors.white,),
      done: Text('Done', style: font.copyWith(fontWeight: FontWeight.w600,color: Colors.white)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
        ),
      ),
    );
  }
}
