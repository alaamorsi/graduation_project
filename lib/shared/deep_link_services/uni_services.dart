import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/tutor/home/add_course/select_course_type.dart';
import 'package:uni_links2/uni_links.dart';

class UniServices{
  static String _code = '';
  static String get code => _code;
  static bool get hasCode => _code.isNotEmpty;
  static void  reset() => _code = '';

  static init() async {
    try {
      final Uri? uri = await getInitialUri();
      uniHandler(uri);
    } on PlatformException catch(e) {
      print("failed to receive the code");
    } on FormatException {
      print("wrong format the code");
    }

    uriLinkStream.listen((Uri? uri) {
      uniHandler(uri);
    }, onError: (err) {
      print('Error: $err');
    });
  }

  static uniHandler(Uri? uri){
    if(uri == null || uri.queryParameters.isEmpty)return;
    Map<String,String> param = uri.queryParameters;

    String success = param['success']??'';
    Get.to(()=>SelectCourseType(successPayment: success,));
  }
}