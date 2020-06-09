import 'package:feminae/model/facility_services.dart';

class FacilityServiceResponse {
  final String status;
  final List<FacilityServices> services;
  final String error;

  FacilityServiceResponse(this.status, this.services, this.error);

  FacilityServiceResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        services = (json['data'] as List)
            .map((e) => FacilityServices.fromJson(e))
            .toList(),
        error = "";

  FacilityServiceResponse.withError(String errorValue)
      : status = 'error',
        services = List(),
        error = errorValue;
}
