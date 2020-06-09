import 'package:feminae/model/facility_response.dart';
import 'package:feminae/model/facility_service_response.dart';
import 'package:feminae/network/api_providers/facility_api_provider.dart';
import 'package:feminae/network/api_providers/login_api_provider.dart';

class FacilityRepository {
  FacilityApiProvider _apiProvider = FacilityApiProvider();
  final LoginApiProvider _loginApiProvider = LoginApiProvider();

  Future<FacilityResponse> getFacilities(String token, String facilityType) {
    return _apiProvider.getFacilities(token, facilityType);
  }

  Future<FacilityServiceResponse> getFacilityServices(int id, String token, String facilityType) {
    return _apiProvider.getFacilityServices(id, token, facilityType);
  }

  Future<String> getLoginStatus(String email, String password) =>
      _loginApiProvider.getLoginStatus(email, password);
}
