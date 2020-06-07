import 'package:feminae/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:feminae/utils/constants.dart';

class LoginApiProvider {
  final String _endPoint = ENDPOINT_URL;
  final Dio _dio = Dio();

  Future<String> getLoginStatus(String email, String password) async {
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    final formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    try {
      Response response = await _dio.post(_endPoint, data: formData);
      print(LoginResponse.fromJson(response.data).login.token);
      return LoginResponse.fromJson(response.data).login.token;
    } catch (error, stacktrace) {
      print('Exception Occured: $error StackTrace: $stacktrace');
      return LoginResponse.withError(error).status;
    }
  }
}
