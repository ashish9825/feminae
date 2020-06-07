import 'package:feminae/model/facility_response.dart';
import 'package:feminae/model/facility_service_response.dart';
import 'package:feminae/network/api_providers/facility_api_provider.dart';
import 'package:feminae/network/api_providers/login_api_provider.dart';

class FacilityRepository {
  FacilityApiProvider _apiProvider = FacilityApiProvider();
  final LoginApiProvider _loginApiProvider = LoginApiProvider();

  Future<FacilityResponse> getFacilities() {
    return _apiProvider.getFacilities();
  }

  Future<FacilityServiceResponse> getFacilityServices(int id) {
    return _apiProvider.getFacilityServices(id);
  }

  Future<String> getLoginStatus(String email, password) =>
      _loginApiProvider.getLoginStatus(email, password);
}
