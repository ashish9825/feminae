import 'package:feminae/model/facility_services.dart';

class FacilityServiceResponse {
  final List<FacilityServices> services;
  final String error;

  FacilityServiceResponse(this.services, this.error);

  FacilityServiceResponse.fromJson(Map<String, dynamic> json)
      : services = (json['salonFacilities'] as List)
            .map((e) => FacilityServices.fromJson(e))
            .toList(),
        error = "";

  FacilityServiceResponse.withError(String errorValue)
      : services = List(),
        error = errorValue;
}
