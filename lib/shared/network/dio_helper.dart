import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        // 'Authorization': 'b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV'
        baseUrl: 'http://ahmedad-001-site1.gtempurl.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData ({
    required String url,
    Map<String,dynamic>? query,
    String lang ='en',
    String? token,
  })async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token,
    };
    return await dio.get(url ,queryParameters: query);
  }

  static Future<Response> postData ({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang ='ar',
    String? token,
  })async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Basic MTExNjMwOTY6NjAtZGF5ZnJlZXRyaWFs',
    };
    return dio.post(url,queryParameters: query,data: data);
  }
}