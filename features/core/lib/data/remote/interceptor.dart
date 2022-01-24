import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final String? token;

  TokenInterceptor({this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) options.headers['Authorization'] = 'Bearer $token';
    return super.onRequest(options, handler);
  }
}
