import 'package:dio/dio.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

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
    String? token,
  })async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':token,
    };
    return await dio.get(url ,queryParameters: query);
  }

  static Future<Response> postData ({
    required String url,
    required Map<String,dynamic> data,
    String? token,
  })async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Basic MTExNjMwOTY6NjAtZGF5ZnJlZXRyaWFs',
    };
    return dio.post(url,data: data,);
  }

  static Future<Response> patchData ({
    required String url,
    required List<Map<String,dynamic>>  data,
    String? token,
  })async
  {
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Basic MTExNjMwOTY6NjAtZGF5ZnJlZXRyaWFs',
      'AuthorizationJwt':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    return dio.post(url,data: data,);
  }
}