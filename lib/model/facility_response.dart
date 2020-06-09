import 'package:feminae/model/facilities.dart';

class FacilityResponse {
  final String status;
  final List<Facility> facilities;
  final String error;

  FacilityResponse(this.status, this.facilities, this.error);

  FacilityResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        facilities =
            (json['data'] as List).map((f) => Facility.fromJson(f)).toList(),
        error = "";

  FacilityResponse.withError(String errorValue)
      : status = 'error',
        facilities = List(),
        error = errorValue;
}
