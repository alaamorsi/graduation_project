import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/modules/student/my_courses/screens/course_leader.dart';
import 'package:graduation_project/modules/tutor/home/courses/publish_course.dart';
import 'package:graduation_project/shared/component/test.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key, required this.paymentKey});

  final String paymentKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:
            "https://accept.paymob.com/api/acceptance/iframes/830423?payment_token=$paymentKey",
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) {
          if (request.url.contains('success')) {
            // Navigate to the success screen
            if (CacheHelper.getData(key: 'role') == 'instructor') {
              Future.delayed(const Duration(seconds: 3)).then((value) {
                Get.off(() => const PublishCourse());
              });
            }
            if (CacheHelper.getData(key: 'role') == 'student') {
              Future.delayed(const Duration(seconds: 3)).then((value) {
                Get.off(() => ClassLeader(
                      course: myCourses[1],
                    ));
              });
            }
            return NavigationDecision.prevent;
          } else if (request.url.contains('failure')) {
            // Handle payment failure if needed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FailureScreen()),
            );
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Success"),
      ),
      body: const Center(
        child: Text("Payment was successful!"),
      ),
    );
  }
}

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Failure"),
      ),
      body: const Center(
        child: Text("Payment failed, please try again."),
      ),
    );
  }
}
