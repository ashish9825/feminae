import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:feminae/model/facility_response.dart';
import 'package:feminae/model/facility_service_response.dart';
import 'package:feminae/utils/constants.dart';
import 'package:feminae/utils/logging_interceptor.dart';

class FacilityApiProvider {
  final String _endPoint = ENDPOINT_URL;
  Dio _dio;

  FacilityApiProvider() {
    // BaseOptions options =
    //     BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    _dio = Dio();
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<FacilityResponse> getFacilities(
      String token, String facilityType) async {
    try {
      _dio.options.headers = {"token": token};
      Response response = await _dio.get('$_endPoint/$facilityType');

      return FacilityResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FacilityResponse.withError(_handleError(error));
    }
  }

  Future<FacilityServiceResponse> getFacilityServices(
      int id, String token, String facilityType) async {
    try {
      _dio.options.headers = {"token": token};
      Response response = await _dio.get('$_endPoint/$facilityType/$id');

      // List jsonResponse = json.decode(jsonEncode(response.data));
      // print('Response : $jsonResponse[0]');
      return FacilityServiceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return FacilityServiceResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = "";

    if (error is DioError) {
      DioError dioError = error as DioError;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${dioError.response.statusCode}";
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
