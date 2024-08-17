import 'package:authentication/data/remote/apis_url/auth_api_urls.dart';
import 'package:authentication/data/remote/aut_api.dart';
import 'package:authentication/data/remote/auth_service.dart';
import 'package:core/domain/user_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'test_remote_auth.mocks.dart';

@GenerateMocks([Response],
    customMocks: [MockSpec<Dio>()])
void main() {
  late AuthApiService remoteAuth;
  late Dio dio;
  late Response response;

  setUp(() {
    dio = MockDio();
    response = MockResponse();
    remoteAuth = AuthApiServiceImp(dio: dio);
  });

  tearDown(() {
    clearInteractions(dio);
  });

  test("login with valid user", () async {
    when(response.statusCode).thenReturn(200);
    when(response.data).thenReturn({"token": "token", "userType": "user"});
    when(dio.post(LOGIN,
        data: {"phone": "test", "password": "password"},
        queryParameters: {"lang": "lang"})).thenAnswer((_) async => response);

    var result = await remoteAuth.login("test", "password");
    String? token = result.responseData?.token;
    UserType? type = result.responseData?.userType;
    expect(token, "token");
    expect(type, UserType.user);
  });

  test("login with invalid user", () async {
    when(response.statusCode).thenReturn(400);
    when(response.data).thenReturn({"message": "User not found"});

    when(dio.post(
      LOGIN,
      data: {"email": "test", "password": "password"},
    )).thenAnswer((_) async => response);

    var result = await remoteAuth.login("test", "password");
    expect(result.errorMessage?.isNotEmpty, true);
  });
}
