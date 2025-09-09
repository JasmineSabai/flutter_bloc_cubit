import 'package:dio/dio.dart';

import '../constants/app_configs.dart';
import '../utilities/app_session.dart';
import 'api_client.dart';

class ApiService {
  late ApiClient _client;
  late Dio _dio;

  ApiService() {
    _dio = Dio();

    // Add interceptor to inject auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer ${AppSession.appToken}';
        return handler.next(options);
      },
    ));

    // Initialize Retrofit client with dynamic baseUrl
    _client = ApiClient(_dio, baseUrl: AppConfigs.apiDomain);
  }

  ApiClient get client => _client;

  // Optional: method to update token or baseUrl dynamically
  void update({
    required String token,
    required String baseUrl,
  }) {
    _dio.options.baseUrl = baseUrl;

    // Update interceptor header — simpler way: clear and add again
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }
}