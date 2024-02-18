import 'package:flutter/material.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';

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
        child: MaterialButton(
          color: HexColor("#000080"),
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0,color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () => onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "اختر بحرية",
          body: "اختر من بين مئات المدرسين والدروس الاونلاين والمسجلة",
          image: Image.asset("Assets/intro1.png",height: 270.0),),
        PageViewModel(
          title: "تعليم سهل ومسلي",
          body: "استمتع بمشاهدة مقدمة مجانية من كل المحتويات قبل الشراء , قيم واسأل فى كل درساً على حدا ",
          image: Image.asset("Assets/intro2.png",height: 270.0),),
        PageViewModel(
          title: "ارتقي بمستواك",
          body: "قم بحل المهمة المنزلة على كل درس لإختبار مستواك",
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
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
      next: const Icon(Icons.arrow_forward,color: Colors.white,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
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
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
