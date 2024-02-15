import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import '../../../modules/login/data/data/models/login_request_body.dart';
import '../../../modules/login/data/data/models/login_respone.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);
}
