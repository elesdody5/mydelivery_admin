import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'apis_url.dart';
import 'interceptor.dart';

class DioBuilder {
  static Dio? _dio;
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  static final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    headers: header,
    followRedirects: false,
    validateStatus: (status) => true,
  );

  DioBuilder._privateConstructor();

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(_options);

      _dio?.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    return _dio!;
  }

  static void addInterceptor(String token) {
    _dio?.interceptors.add(TokenInterceptor(token: token));
  }
}
