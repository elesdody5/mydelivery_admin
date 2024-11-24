import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  final String? token;
  final String? cityId;

  ApiInterceptor({this.token, this.cityId});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    if (cityId != null) options.headers['cityId'] = cityId!;
    return super.onRequest(options, handler);
  }
}
