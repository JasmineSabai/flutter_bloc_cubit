import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../scenes/base/model/base_request.dart';
import '../scenes/base/model/base_response.dart';
import '../scenes/login/model/login_request.dart';
import '../scenes/login/model/login_response.dart';

part 'api_client.g.dart';
//flutter pub run build_runner build --delete-conflicting-outputs

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @POST("/user/login")
  Future<BaseResponse<LoginResponse>> loginWithEmail(@Body() BaseRequest<LoginRequest> request);

// Add other API methods here...
}