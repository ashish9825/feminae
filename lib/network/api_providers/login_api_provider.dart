import 'package:feminae/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:feminae/utils/constants.dart';

class LoginApiProvider {
  final String _endPoint = ENDPOINT_URL;
  final Dio _dio = Dio();

  Future<String> getLoginStatus(String email, String password) async {
    _dio.options.contentType = Headers.formUrlEncodedContentType;

    final formData = {
      'email': email,
      'password': password,
    };
    try {
      Response response = await _dio.post(
        '$_endPoint/auth/signin',
        data: formData,
      );
      print(LoginResponse.fromJson(response.data).login.token);

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data).login.token;
      } else {
        return LoginResponse.fromJson(response.data).error;
      }
    } catch (error, stacktrace) {
      print('Exception Occured: $error StackTrace: $stacktrace');
      print('RESPONSE :  ${error.toString().substring(error.toString().length-4, error.toString().length-1)}');
      return LoginResponse.withError('$error').status;
    }
  }
}
