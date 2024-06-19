import 'package:dio/dio.dart';
import 'package:graduation_project/shared/network/cache_helper.dart';

class DioHelper
{
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://digitutors.runasp.net/api/',
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
      // 'Content-Type':'application/json',
      'Authorization':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response<dynamic> response = await dio.get(url ,queryParameters: query);
      return response;
    }catch(e){
      rethrow;
    }
  }

  static Future<Response> postData ({
    required String url,
    required Map<String,dynamic> data,
    String? token,
  }) async{
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Bearer ${CacheHelper.getData(key: 'jwt')}',
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
      'Authorization':'Bearer ${CacheHelper.getData(key: 'jwt')}',
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
    FormData? data,
  }) async{
    dio.options.headers ={
      'Content-Type':'application/json',
      'Authorization':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response<dynamic> response = await dio.post(url,data: data,);
      (response.statusCode);
      return response;
    } catch(e){
      (e);
      rethrow;
    }
  }

  static Future<Response> delete ({
    required String url,
    Map<String, String>? data,
  }) async{
    dio.options.headers ={
      'Authorization':'Bearer ${CacheHelper.getData(key: 'jwt')}',
    };
    try{
      Response response = await dio.delete(url,data: data,);
      return response;
    } catch(e){
      rethrow;
    }
  }
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async
  {
    dio.options.headers =
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token??'',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}