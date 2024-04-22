import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://alaamorsy-001-site1.anytempurl.com/api/',
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
  }) async{
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Basic MTExNzI5ODk6NjAtZGF5ZnJlZXRyaWFs',
    };
    try{
      Response<dynamic> response = await dio.post(url,data: data,);
      return response;
    }
    catch(e){
      rethrow;
    }
  }

  static Future<Response> patchData ({
    required String url,
    required List<Map<String,dynamic>>  data,
    String? token,
  })
  async {
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Basic MTExNzI5ODk6NjAtZGF5ZnJlZXRyaWFs',
      'AuthorizationJwt':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response<dynamic> response = await dio.patch(url,data: data,);
      return response;
    } catch(e){
      rethrow;
    }
  }

  static Future<Response> updateImage ({
    required String url,
    required FormData data,
  }) async{
    dio.options.headers ={
      'Authorization':'Basic MTExNzI5ODk6NjAtZGF5ZnJlZXRyaWFs',
      'AuthorizationJwt':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response<dynamic> response = await dio.post(url,data: data,);
      return response;
    } catch(e){
      rethrow;
    }
  }

  static Future<Response> delete ({
    required String url,
    required String token,
  }) async{
    dio.options.headers ={
      'Authorization':'Basic MTExNzI5ODk6NjAtZGF5ZnJlZXRyaWFs',
      'AuthorizationJwt':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response<dynamic> response = await dio.delete(url,data: jsonEncode(token),);
      return response;
    } catch(e){
      rethrow;
    }
  }
}